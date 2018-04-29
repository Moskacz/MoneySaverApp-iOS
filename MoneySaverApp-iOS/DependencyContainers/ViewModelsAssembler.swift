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
        
        container.register { (dateRange: DateRange) in
            TransactionsOverviewViewModel(repository: try container.resolve(),
                                          logger: try container.resolve(),
                                          calendar: try container.resolve(),
                                          timeChangedObserver: try container.resolve(),
                                          computingService: try container.resolve(),
                                          dateRange: dateRange)
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
        
        container.register {
            StatsViewModel(repository: $0, dataProcessor: $1)
        }
        
        container.register {
            DateRangePickerViewModel(calendar: $0)
        }
    }
}
