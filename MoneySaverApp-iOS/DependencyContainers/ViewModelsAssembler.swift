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
            TransactionsListViewModel(repository: $0,
                                      transactionsComputingService: $1,
                                      logger: $2,
                                      calendar: $3,
                                      timeChangedObserver: $4) as TransactionsListViewModel
        }
        
        container.register {
            TransactionDataViewModel()
        }
        
        container.register {
            TransactionCategoriesCollectionViewModel(service: $0,
                                                     logger: $1)
        }
        
        container.register {
            BudgetViewModel(computingService: $0,
                            dataProcessor: $1,
                            budgetRepository: $2,
                            service: $3)
        }
        
        container.register {
            SetupBudgetViewModel(budgetRepository: $0)
        }
    }
}
