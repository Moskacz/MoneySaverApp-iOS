//
//  DataLayerAssembler.swift
//  MoneySaverApp-iOS
//
//  Created by Michał Moskała on 03.04.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation
import Dip

struct DataLayerAssembler: ContainerAssembly {
    
    func assembly(container: DependencyContainer) {
        container.register {
            CoreDataStackImplementation() as CoreDataStack
        }
    }
}
