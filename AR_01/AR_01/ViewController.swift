//
//  ViewController.swift
//  AR_01
//
//  Created by sunShine on 2023/7/13.
//

import UIKit
import RealityKit
import ARKit

class ViewController: UIViewController {
    
    @IBOutlet var arView: ARView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        arView.session.delegate = self
        arView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:))))
        setupARView()
    }
    
    func setupARView(){
        arView.automaticallyConfigureSession = false
        let configurtion = ARWorldTrackingConfiguration()
        configurtion.planeDetection = [.horizontal, .vertical]
        configurtion.environmentTexturing = .automatic
        arView.session.run(configurtion)
    }
    @objc
    func handleTap(recognizer: UITapGestureRecognizer){
        let location = recognizer.location(in: arView)
        
        
        let result = arView.raycast(from: location, allowing: .estimatedPlane, alignment: .any)
        
        guard let rayResult = arView.ray(through: location) else{return}
        
        let newR = arView.scene.raycast(origin: rayResult.origin, direction: rayResult.direction)
        // check tap place have object
        if let firstResult = newR.first{
//            let anchor = ARAnchor(name: "toy_car", transform: firstResult.worldTransform)
//            arView.session.add(anchor: anchor)
            var position = firstResult.position
            position.y += 1
            let anchorE = AnchorEntity(world: position)
            
            
            let entity = try! ModelEntity.loadModel(named: "Scene2")
            entity.generateCollisionShapes(recursive: true)
            arView.installGestures([.rotation, .translation], for: entity)
            anchorE.addChild(entity)
            arView.scene.addAnchor(anchorE)
        }else{
            if let firstResult = result.first {
                let anchor = ARAnchor(name: "Scene2", transform: firstResult.worldTransform)
                arView.session.add(anchor: anchor)
            }
        }
        
        // only place
//        if let firstResult = result.first {
//            let anchor = ARAnchor(name: "toy_car", transform: firstResult.worldTransform)
//            arView.session.add(anchor: anchor)
//        }
    }
    func placeObject(name: String, for anchor: ARAnchor){
        let entity = try! ModelEntity.loadModel(named: name)
        
        // 播放模型自带动画
        for anim in entity.availableAnimations {
            entity.playAnimation(anim.repeat(duration: .infinity), transitionDuration: 1.25, startsPaused: false)
        }
        entity.generateCollisionShapes(recursive: true)
        arView.installGestures([.rotation, .translation], for: entity)
        
        let anchorEntity = AnchorEntity(anchor: anchor)
        anchorEntity.addChild(entity)
        arView.scene.addAnchor(anchorEntity)
    }
}
extension ViewController: ARSessionDelegate{
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
        for anchor in anchors {
            if let anchorName = anchor.name, anchorName == "Scene2"{
                placeObject(name: anchorName, for: anchor)
            }
        }
    }
}
