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
    var allDataFRC: NSFetchedResultsController<TransactionManagedObject> { get }
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
    
    var allDataFRC: NSFetchedResultsController<TransactionManagedObject> {
        get {
            let transactionsFR = repository.fetchRequest
            transactionsFR.includesPropertyValues = true
            transactionsFR.fetchBatchSize = 20
            transactionsFR.sortDescriptors = [TransactionManagedObject.SortDescriptors.dayOfYear.value,
                                              TransactionManagedObject.SortDescriptors.creationTimeInterval.value]
            
            return NSFetchedResultsController(fetchRequest: transactionsFR,
                                              managedObjectContext: repository.context,
                                              sectionNameKeyPath: TransactionManagedObject.AttributesNames.dayOfYear.rawValue,
                                              cacheName: nil)
        }
    }
    
    func addTransaction(data: TransactionData, category: TransactionCategoryManagedObject) {
        repository.addTransaction(data: data, category: category)
    }
    
    func remove(transaction: TransactionManagedObject) {
        repository.remove(transaction: transaction)
    }
}
