//
//  ContentView.swift
//  swiftUI_AR
//
//  Created by sunShine on 2023/7/11.
//

import SwiftUI
import RealityKit
import ARKit
import FocusEntity

struct ContentView : View {
    @State private var isPlacementEnabled = false
    @State private var selectedModel: Model?
    @State private var modelConfirmForPlacement: Model?
    
    var models: [Model] = [Model(modelName: "toy_car"), Model(modelName: "toy_biplane_idl")]

    var body: some View {
        ZStack(alignment: .bottom, content: {
            ARViewContainer(modelConfirmForPlacement: self.$modelConfirmForPlacement)
            
            if self.isPlacementEnabled {
                PlacementBtnView(isPlacementEnabled: self.$isPlacementEnabled, selectedModel: self.$selectedModel, modelConfirmForPlacement: self.$modelConfirmForPlacement)
            }else{
                ModelPicker(isPlacementEnabled: self.$isPlacementEnabled, selectedModel: self.$selectedModel, models: self.models)

            }
            
            
            
        })
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    @Binding var modelConfirmForPlacement: Model?
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal, .vertical]
        if ARWorldTrackingConfiguration.supportsSceneReconstruction(.mesh){
            config.sceneReconstruction = .mesh
        }
        arView.session.run(config)
        _ = FocusEntity(on: arView, focus: .classic)
        return arView
        
    }
    
    
    func updateUIView(_ uiView: ARView, context: Context) {
        if let model = self.modelConfirmForPlacement{
        
            if let modelEntity = model.modelEntity{
                let anchorEntity = AnchorEntity(plane: AnchoringComponent.Target.Alignment.any)
                anchorEntity.addChild(modelEntity.clone(recursive: true))
                
                uiView.scene.addAnchor(anchorEntity)
            }
            
            
            
            DispatchQueue.main.async {
                self.modelConfirmForPlacement = nil
            }
            
        }
    }
    
}


struct ModelPicker: View{
    @Binding var isPlacementEnabled: Bool
    @Binding var selectedModel: Model?
    
    var models: [Model]
    
    var body: some View{
        ScrollView(.horizontal, showsIndicators: false) {
            
            HStack(spacing: 30, content: {
                ForEach(0 ..< self.models.count) { index in
                    Button {
                        print("a")
                        self.isPlacementEnabled = true
                        self.selectedModel = self.models[index]
                    } label: {
                        Image(uiImage:self.models[index].imgae)
                            .resizable()
                            .frame(height: 80)
                            .aspectRatio(1/1, contentMode: .fit)
                            .background(Color.white)
                            .cornerRadius(12)
                    }.buttonStyle(PlainButtonStyle())
                }
            })
        }
        .padding(20)
        .background(Color.black.opacity(0.5))
    }
}
struct PlacementBtnView: View {
    @Binding var isPlacementEnabled: Bool
    @Binding var selectedModel: Model?
    @Binding var modelConfirmForPlacement: Model?
    
    var body: some View {
        HStack{
            Button(action: {
                print("cancel btn")
                self.resetPlacementParameers()
            }, label: {
               Image(systemName: "xmark")
                    .frame(width: 40, height: 60)
                    .font(.title)
                    .background(Color.white.opacity(0.75))
                    .cornerRadius(30)
                    .padding(20)
            })
            
            Button(action: {
                print("confirm btn")
                self.modelConfirmForPlacement = self.selectedModel
                self.resetPlacementParameers()
            }, label: {
               Image(systemName: "checkmark")
                    .frame(width: 40, height: 60)
                    .font(.title)
                    .background(Color.white.opacity(0.75))
                    .cornerRadius(30)
                    .padding(20)
            })
        }
    }
    func resetPlacementParameers(){
        self.isPlacementEnabled = false
        self.selectedModel = nil
    }
}

//#Preview {
//    ContentView()
//}
