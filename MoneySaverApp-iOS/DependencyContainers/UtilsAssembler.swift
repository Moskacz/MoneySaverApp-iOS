//
//  UtilsAssembler.swift
//  MoneySaverApp-iOS
//
//  Created by Michał Moskała on 14.05.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation
import Dip

class UtilsAssebler: ContainerAssembly {
    
    func assembly(container: DependencyContainer) {
        container.register(.singleton) {
            NullLogger() as Logger
        }
        
        container.register {
            ChartsDataProcessorImpl() as ChartsDataProcessor
        }
        
        container.register {
            Calendar.current
        }
        
        container.register {
            TimeChangedObserver(notificationCenter: $0)
        }
    }
}
