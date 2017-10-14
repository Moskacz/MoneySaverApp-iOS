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
        container.register(.singleton) {
            CoreDataStackImplementation() as CoreDataStack
        }
        
        container.register(.singleton) {
            TransactionsRepositoryImplementation(stack: $0) as TransactionsRepository
        }
        
        container.register(.singleton) {
            TransactionCategoryRepositoryImpl(stack: $0, logger: $1) as TransactionCategoryRepository
        }
        
        container.register {
            InitialDataPrefillerImpl() as InitialDataPrefiller
        }
        
        container.register(.singleton) {
            TransactionCategoryServiceImpl(repository: $0) as TransactionCategoryService
        }
    }
}
