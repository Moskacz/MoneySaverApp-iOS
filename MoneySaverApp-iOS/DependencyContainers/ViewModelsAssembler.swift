//
//  ViewModelsAssembler.swift
//  MoneySaverApp-iOS
//
//  Created by Michał Moskała on 03.04.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation
import Dip

struct ViewModelsAssembler: ContainerAssembly {
    
    func assembly(container: DependencyContainer) {
        container.register {
            TransactionsListViewModel(transactionsService: $0,
                                      transactionsComputingService: $1,
                                      logger: $2) as TransactionsListViewModel
        }
        
        container.register {
            TransactionDataViewModel()
        }
        
        container.register {
            TransactionCategoriesCollectionViewModel(service: $0, logger: $1)
        }
    }
}
