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
        container.register {
            CoreDataStackImplementation(dataPrefiller: $0) as CoreDataStack
        }
        
        container.register {
            TransactionsRepositoryImplementation(stack: $0) as TransactionsRepository
        }
        
        container.register {
            TransactionCategoryRepositoryImpl(stack: $0) as TransactionCategoryRepository
        }
        
        container.register {
            InitialDataPrefillerImpl(repository: $0) as InitialDataPrefiller
        }
    }
}
