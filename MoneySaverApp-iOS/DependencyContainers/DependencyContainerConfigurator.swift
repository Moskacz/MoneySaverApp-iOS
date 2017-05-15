//
//  DependencyContainerConfigurator.swift
//  MoneySaverApp-iOS
//
//  Created by Michał Moskała on 03.04.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation
import Dip

extension DependencyContainer {
    
    static func createContainer() -> DependencyContainer {
        let assemblers: [ContainerAssembly] = [NetworkingLayerAssembler(),
                                               DataLayerAssembler(),
                                               ModelsAssembler(),
                                               ViewModelsAssembler(),
                                               MappersAssembler(),
                                               UtilsAssebler()]
        
        let container = DependencyContainer()
        for assembler in assemblers {
            assembler.assembly(container: container)
        }
        
        return container
    }
    
}
