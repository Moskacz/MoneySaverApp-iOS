//
//  TransactionsModel.swift
//  MoneySaverApp-iOS
//
//  Created by Michał Moskała on 27.03.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation
import MoneySaverFoundationiOS
import CoreData

protocol TransactionsService {
    func allDataFRC() -> NSFetchedResultsController<TransactionManagedObject>
    func addTransaction(data: TransactionData, category: TransactionCategoryManagedObject)
    func remove(transaction: TransactionManagedObject)
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
    
    func allDataFRC() -> NSFetchedResultsController<TransactionManagedObject> {
        let transactionsFR = repository.fetchRequest
        transactionsFR.includesPropertyValues = true
        transactionsFR.fetchBatchSize = 20
        transactionsFR.sortDescriptors = [repository.sortDescriptor]
        
        return NSFetchedResultsController(fetchRequest: transactionsFR,
                                          managedObjectContext: repository.context,
                                          sectionNameKeyPath: "dayOfYear",
                                          cacheName: nil)
    }
    
    func addTransaction(data: TransactionData, category: TransactionCategoryManagedObject) {
        repository.addTransaction(data: data, category: category)
    }
    
    func remove(transaction: TransactionManagedObject) {
        repository.remove(transaction: transaction)
    }
}
