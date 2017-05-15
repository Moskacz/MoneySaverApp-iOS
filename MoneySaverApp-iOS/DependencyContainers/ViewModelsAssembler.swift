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
            TransactionsListViewModel(transactionsModel: $0,
                                      transactionsComputingModel: $1,
                                      logger: $2) as TransactionsListViewModel
        }
        
        container.register {
            AddTransactionViewModel(transactionsModel: $0, mapper: $1) as AddTransactionViewModel
        }
    }
}
