//
//  TransactionRepository.swift
//  MoneySaverApp-iOS
//
//  Created by Michał Moskała on 15.04.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation
import CoreData
import MoneySaverFoundationiOS

protocol TransactionsRepository {
    func add(transaction: Transaction)
    func allDataFRC(completion: @escaping ((NSFetchedResultsController<TransactionManagedObject>) -> Void))
}

class TransactionsRepositoryImplementation: TransactionsRepository {
    
    private let stack: CoreDataStack
    private let logger: Logger
    
    init(stack: CoreDataStack, logger: Logger) {
        self.stack = stack
        self.logger = logger
    }
    
    func allDataFRC(completion: @escaping ((NSFetchedResultsController<TransactionManagedObject>) -> Void)) {
        stack.getViewContext { (context) in
            let fetchRequest = self.allDataFetchRequest()
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "creationTimeInterval", ascending: true)]
            let frc = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                 managedObjectContext: context,
                                                 sectionNameKeyPath: nil,
                                                 cacheName: nil)
            completion(frc)
        }
    }
    
//    func update(withTransactions transactions: [Transaction]) {
//        stack.getViewContext { (context) in
//            context.perform {
//                if let storedData = self.getAllData(inContext: context) {
//                    if let transactionsToDelete = self.filtered(transactions: storedData,
//                                                                notIncludedInData: transactions) {
//                        self.delete(transactions: transactionsToDelete,
//                                    fromContext: context)
//                    }
//                    self.updateOrCreateNewEntities(basedOnTransactions: transactions,
//                                                   storedTransactions: storedData,
//                                                   inContext: context)
//                } else {
//                    self.createNewEntities(basedOnTransactions: transactions, inContext: context)
//                }
//
//                do {
//                    try context.save()
//                } catch {
//                    print(error)
//                }
//            }
//        }
//    }
    
    func add(transaction: Transaction) {
        stack.getViewContext { (context) in
            context.perform {
                let entity = TransactionManagedObject.createEntity(inContext: context)
                self.updateProperties(ofTransactionEntity: entity, withTransaction: transaction)
                
                do {
                    try context.save()
                } catch {
                    self.logger.log(withLevel: .error, message: error.localizedDescription)
                }
            }
        }
    }
    
    // MARK: private
    
    private func getAllData(inContext context: NSManagedObjectContext) -> [TransactionManagedObject]? {
        let fetchRequest = allDataFetchRequest()
        do {
            return try context.fetch(fetchRequest)
        } catch {
            return nil
        }
    }
    
    private func allDataFetchRequest() -> NSFetchRequest<TransactionManagedObject> {
        return TransactionManagedObject.fetchRequest()
    }
    
    private func filtered(transactions: [TransactionManagedObject],
                          notIncludedInData data: [Transaction]) -> [TransactionManagedObject]? {
        return transactions.filter { (storedTransaction: TransactionManagedObject) in
            let matchingTransaction = data.first(where: { (transaction: Transaction) -> Bool in
                return transaction.identifier == storedTransaction.identifier
            })
            return matchingTransaction == nil
        }
    }
    
    private func delete(transactions: [TransactionManagedObject], fromContext context: NSManagedObjectContext) {
        for transaction in transactions {
            context.delete(transaction)
        }
    }
    
    private func updateOrCreateNewEntities(basedOnTransactions transactions: [Transaction],
                                           storedTransactions: [TransactionManagedObject],
                                           inContext context: NSManagedObjectContext) {
        for transaction in transactions {
            
            let transactionEntity: TransactionManagedObject
            let matchingEntity = storedTransactions.first(where: { (storedTransaction: TransactionManagedObject) -> Bool in
                storedTransaction.identifier == transaction.identifier
            })
            
            if let entity = matchingEntity {
                transactionEntity = entity
            } else {
                transactionEntity = TransactionManagedObject.createEntity(inContext: context)
            }
            
            updateProperties(ofTransactionEntity: transactionEntity, withTransaction: transaction)
        }
    }
    
    private func createNewEntities(basedOnTransactions transactions: [Transaction], inContext context: NSManagedObjectContext) {
        for transaction in transactions {
            let entity = TransactionManagedObject.createEntity(inContext: context)
            updateProperties(ofTransactionEntity: entity, withTransaction: transaction)
        }
    }
    
    private func updateProperties(ofTransactionEntity transactionEntity: TransactionManagedObject,
                                  withTransaction transaction: Transaction) {
        transactionEntity.identifier = transaction.identifier
        transactionEntity.title = transaction.title
        transactionEntity.value = transaction.value
        transactionEntity.creationTimeInterval = transaction.creationTimeInterval
    }
}
