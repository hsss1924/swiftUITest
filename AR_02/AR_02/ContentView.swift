//
//  ContentView.swift
//  AR_02
//
//  Created by sunShine on 2023/7/13.
//

import SwiftUI
import RealityKit
import AVFoundation

struct ContentView : View {
    var body: some View {
        ARViewContainer().edgesIgnoringSafeArea(.all)
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)

       spawnTV(in: arView )

        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
    
    func spawnTV(in arView: ARView){
        let dimensions: SIMD3<Float> = [1.23, 0.046, 0.7]
        
        //create TV Housing
        let housingMesh = MeshResource.generateBox(size: dimensions)
        
        let housingMat = SimpleMaterial(color: .black, roughness: 0.4,isMetallic: false)
        
        let housingEntity = ModelEntity(mesh: housingMesh, materials: [housingMat])
        
        //create TV screen
        let screenMesh = MeshResource.generatePlane(width: dimensions.x, depth: dimensions.z)
        let screenMat = SimpleMaterial(color: .white, roughness: 0.2,isMetallic: false)
        let screenEntity = ModelEntity(mesh: screenMesh, materials: [screenMat])
        screenEntity.name = "tv"
        
        // add tv screen to housing
        housingEntity.addChild(screenEntity)
        screenEntity.setPosition([0, dimensions.y/2 + 0.001, 0], relativeTo: housingEntity)
        
        //create anchor to place tv on wall
        let anchor = AnchorEntity(plane: .vertical)
        anchor.addChild(housingEntity)
        arView.scene.addAnchor(anchor)
        
        arView.enableTapGesture()
        housingEntity.generateCollisionShapes(recursive: true)
        
    }
}
extension ARView{
    func enableTapGesture(){
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:)))
        self.addGestureRecognizer(tapGes)
    }
    @objc func handleTap(recognizer: UITapGestureRecognizer){
        let tapLocation = recognizer.location(in: self)
        
        if let entity = self.entity(at: tapLocation) as? ModelEntity, entity.name == "tv"{
            loadVideoMaterial(for: entity)
        }
    }
    
    func loadVideoMaterial(for entity: ModelEntity){
        let asset = AVAsset(url: Bundle.main.url(forResource: "demo", withExtension: "MOV")!)
        let playerItem = AVPlayerItem(asset: asset)
        let player = AVPlayer()
        entity.model?.materials = [VideoMaterial(avPlayer: player)]
        
        player.replaceCurrentItem(with: playerItem)
        player.play()
        
    }
}
//#Preview {
//    ContentView()
//}
