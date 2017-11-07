//
//  TransactionsModel.swift
//  MoneySaverApp-iOS
//
//  Created by Michał Moskała on 27.03.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation
import MoneySaverFoundationiOS

protocol TransactionsService {
    func getRepository() -> TransactionsRepository
    func addTransaction(data: TransactionData, category: TransactionCategoryManagedObject)
}

class TransactionsServiceImpl: TransactionsService {
    
    private let serverInterface: TransactionsServerInterface
    private let repository: TransactionsRepository
    private let logger: Logger
    
    init(serverInterface: TransactionsServerInterface,
         repository: TransactionsRepository,
         logger: Logger) {
        self.serverInterface = serverInterface
        self.repository = repository
        self.logger = logger
    }
    
    func getRepository() -> TransactionsRepository {
        return repository
    }
    
    func addTransaction(data: TransactionData, category: TransactionCategoryManagedObject) {
        repository.addTransaction(data: data, category: category)
    }
}
