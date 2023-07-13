//
//  Model.swift
//  swiftUI_AR
//
//  Created by sunShine on 2023/7/12.
//

import UIKit
import RealityKit
import Combine


class Model{
    var modelName: String
    var imgae: UIImage
    var modelEntity: ModelEntity?
    
    private var cancellable: AnyCancellable? = nil
    
    init(modelName: String) {
        self.modelName = modelName
        self.imgae = UIImage(named: modelName)!
        let filename = modelName + ".usdz"
        self.cancellable = ModelEntity.loadModelAsync(named: filename)
            .sink(receiveCompletion: { loadCompletion in
                //error
            }, receiveValue: { modelEntity in
                // get our modelEntity
                self.modelEntity = modelEntity
            })
    }
    
}
