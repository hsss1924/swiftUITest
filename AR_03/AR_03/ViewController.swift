//
//  ViewController.swift
//  AR_03
//
//  Created by sunShine on 2023/7/14.
//

import UIKit
import RealityKit
import ARKit
import MultipeerSession

class ViewController: UIViewController {
    
    @IBOutlet var arView: ARView!
    
    var multipeerSession: MultipeerSession?
    var sessionIDObservation: NSKeyValueObservation?
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setUpARView()
        setUpMultipeerSession()
        arView.session.delegate = self
        
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:)))
        arView.addGestureRecognizer(tapGes)
    }
 
    
    func setUpARView(){
        arView.automaticallyConfigureSession = false
        
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal, .vertical]
        config.environmentTexturing = .automatic
        config.isCollaborationEnabled = true
        arView.session.run(config)
        
    }
        
    func setUpMultipeerSession(){
//        sessionIDObservation = observe(\.arView?.session.identifier, options: [.new], changeHandler: { object, change in
//            print("sessionID is \(change.newValue)")
//            
//            guard let multipeerSession = self.multipeerSession else{return}
//            
//            self.sendARSessionIDTo(peers: multipeerSession.connectedPeers)
//            
//        })
        sessionIDObservation = arView.session.observe(\.identifier, changeHandler: { object, change in
            print("sessionID is \(change.newValue)")
            //
                        guard let multipeerSession = self.multipeerSession else{return}
            
                        self.sendARSessionIDTo(peers: multipeerSession.connectedPeers)
        })
        multipeerSession = MultipeerSession(serviceName: "multiuser-ar", receivedDataHandler: self.receivedData, peerJoinedHandler: peerJoined, peerLeftHandler: self.peerLeft, peerDiscoveredHandler: self.peerDiscovered)
    }
    
    @objc func handleTap(recognizer:UITapGestureRecognizer){
        let anchor = ARAnchor(name: "laser", transform: arView.cameraTransform.matrix)
        arView.session.add(anchor: anchor)
        
    }
    func placeObject(named: String, for anchor: ARAnchor){
        let laserEntity = try! ModelEntity.load(named: named)
        
        let anchorEntity = AnchorEntity(anchor: anchor)
        
        anchorEntity.addChild(laserEntity)
        
        arView.scene.addAnchor(anchorEntity)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.55 ){
            self.arView.scene.removeAnchor(anchorEntity)
        }
    }
}

extension ViewController: ARSessionDelegate{
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
        for anchor in anchors{
            if let anchorName = anchor.name, anchorName == "laser"{
                placeObject(named: anchorName, for: anchor)
            }
            if let participantAnchor = anchor as? ARParticipantAnchor
            {
                print("successfully connected with another user")
                let anchorEntity = AnchorEntity(anchor: participantAnchor)
                
                let mesh = MeshResource.generateSphere(radius: 0.03)
                let color = UIColor.red
                let material = SimpleMaterial(color: color, isMetallic: false)
                let coloredSphere = ModelEntity(mesh: mesh, materials: [material])
                anchorEntity.addChild(coloredSphere)
                
                arView.scene.addAnchor(anchorEntity )
            }
        }
    }
    
}

 
extension ViewController{
    private func sendARSessionIDTo(peers: [PeerID]){
        guard let multipeerSession = multipeerSession else{return}
        let isString = arView.session.identifier.uuidString
        let command = "SessionID:" + isString
        if let commandData = command.data(using: .utf8){
            multipeerSession.sendToPeers(commandData, reliably: true, peers: peers)
        }
    }
     
    func receivedData(_ data:Data, from peer: PeerID){
        guard let multipeerSession = multipeerSession else{return}
        
        if let collaborationData = try? NSKeyedUnarchiver.unarchivedObject(ofClass: ARSession.CollaborationData.self, from: data){
            arView.session.update(with: collaborationData)
            return
        }
        
        let sessionIDCommandString = "SessionID:"
        if let commandString = String(data: data, encoding: .utf8), commandString.starts(with: sessionIDCommandString){
            let newSessionID = String(commandString[commandString.index(commandString.startIndex, offsetBy: sessionIDCommandString.count)...])
            
            
            if let oldSessionID = multipeerSession.peerSessionIDs[peer]{
                removeAllAnchorsOriginatingFromARSessionWithID(oldSessionID)
            }
            multipeerSession.peerSessionIDs[peer] = newSessionID
        }
        
        
    }
    func peerDiscovered(_ peer: PeerID) -> Bool{
        guard let multipeerSession = multipeerSession else{return false}
        
        if multipeerSession.connectedPeers.count > 4{
            print("A fifth player wants to join\n the game is currently limited to four players")
            return false
        }else{
            return true
        }
    }
    func peerJoined(_ peer: PeerID){
        print("A player wants to join the game. hold the devices next to each other")
        sendARSessionIDTo(peers: [peer])
    }
    func peerLeft(_ peer: PeerID){
        guard let multipeerSession = multipeerSession else{return}
        print("A player has left the game")
        if let seesionID = multipeerSession.peerSessionIDs[peer]{
            removeAllAnchorsOriginatingFromARSessionWithID(seesionID)
            multipeerSession.peerSessionIDs.removeValue(forKey: peer)
        }
        
    }
    
    private func removeAllAnchorsOriginatingFromARSessionWithID(_ identifier: String){
        guard let frame = arView.session.currentFrame else{return}
        
        for anchor in frame.anchors {
            guard let anchorSessionID = anchor.sessionIdentifier else{continue}
            if anchorSessionID.uuidString == identifier {
                arView.session.remove(anchor: anchor)
                }
            }
        }
    
    func session(_ session: ARSession, didOutputCollaborationData data: ARSession.CollaborationData) {
        guard let multipeerSession = multipeerSession else{return}
        
        if !multipeerSession.connectedPeers.isEmpty{
            guard let encodeData = try? NSKeyedArchiver.archivedData(withRootObject: data, requiringSecureCoding: true)
            else{
                fatalError("enexpectedly failed to encode collaboration data")
            }
            let dataIsCritical = data.priority == .critical
            multipeerSession.sendToAllPeers(encodeData, reliably: dataIsCritical)
        }else{
            print("Deferred sending collaboration to later because there are no peers")
        }
        
    }
}
