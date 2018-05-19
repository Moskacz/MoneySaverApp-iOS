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
        
        container.register {
            TransactionsComputingServiceImpl(repository: $0,
                                             calendar: $1,
                                             notificationCenter: $2,
                                             logger: $3,
                                             timeChangedObserver: $4) as TransactionsComputingService
        }
    }
}
