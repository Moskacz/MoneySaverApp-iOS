//
//  DataLayerAssembler.swift
//  MoneySaverApp-iOS
//
//  Created by Michał Moskała on 03.04.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation
import Dip
import MoneySaverAppCore

struct DataLayerAssembler: ContainerAssembly {
    
    func assembly(container: DependencyContainer) {

        container.register(.singleton) { () -> CoreDataStack in
            let storeURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: AppGroup.group.identifier)?.appendingPathComponent("Database.sqlite")
            return CoreDataStackImplementation(storeURL: storeURL!)
        }
        
        container.register(.singleton) {
            TransactionsRepositoryImplementation(context: $0, logger: $1, calendar: $2) as TransactionsRepository
        }
        
        container.register(.singleton) {
            TransactionCategoryRepositoryImpl(context: $0, logger: $1) as TransactionCategoryRepository
        }
        
        container.register(.singleton) {
            TransactionCategoryServiceImpl(repository: $0) as TransactionCategoryService
        }
        
        container.register(.singleton) {
            BudgetRepositoryImpl(context: $0, logger: $1) as BudgetRepository
        }
        
        container.register {
            RootFlowServiceImpl(repository: $0, userPreferences: $1) as RootFlowService
        }
        
        container.register(.singleton) {
            UserDefaults.standard as UserPreferences
        }
    }
}
