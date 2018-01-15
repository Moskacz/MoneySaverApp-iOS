//
//  RootFlowService.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 14.01.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import Foundation

protocol RootFlowService {
    func addTransaction(withData data: TransactionData, category: TransactionCategoryManagedObject)
}

class RootFlowServiceImpl: RootFlowService {
    
    private let repository: TransactionsRepository
    
    init(repository: TransactionsRepository) {
        self.repository = repository
    }
    
    func addTransaction(withData data: TransactionData, category: TransactionCategoryManagedObject) {
        repository.addTransaction(data: data, category: category)
    }
    
}
