//
//  ViewModelsAssembler.swift
//  MoneySaverApp-iOS
//
//  Created by Michał Moskała on 03.04.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation
import Dip
import MoneySaverAppCore

struct ViewModelsAssembler: ContainerAssembly {
    
    func assembly(container: DependencyContainer) {
        
        container.register {
            TransactionDataViewModel()
        }
        
        container.register {
            TransactionCategoriesCollectionViewModel(service: $0,
                                                     logger: $1)
        }
        
        container.register {
            DateRangePickerViewModel(calendar: $0)
        }
    }
}
