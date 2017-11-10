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
            TransactionsServiceImpl(serverInterface: $0,
                                    repository: $1,
                                    logger: $2) as TransactionsService
        }
        
        container.register {
            TransactionsComputingServiceImpl(context: $0,
                                             notificationCenter: $1,
                                             dateIntervalService: $2,
                                             logger: $3) as TransactionsComputingService
        }
        
        container.register {
            DateIntervalServiceImpl() as DateIntervalService
        }
    }
}
