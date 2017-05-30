//
//  ModelsAssembler.swift
//  MoneySaverApp-iOS
//
//  Created by Michał Moskała on 03.04.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation
import Dip

struct ModelsAssembler: ContainerAssembly {
    
    func assembly(container: DependencyContainer) {
        container.register(.singleton) {
            NotificationCenter.default as NotificationCenter
        }
        
        container.register(.singleton) {
            TransactionsModelImplementation(restClient: $0,
                                            repository: $1,
                                            logger: $2) as TransactionsModel
        }
        
        container.register {
            TransactionsComputingModelImpl(coreDataStack: $0,
                                           notificationCenter: $1,
                                           logger: $2) as TransactionsComputingModel
        }
    }
}
