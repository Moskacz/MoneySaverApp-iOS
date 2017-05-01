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
    func update(withTransactions transactions: [Transaction])
    func add(transaction: Transaction)
    func allDataFRC() -> NSFetchedResultsController<TransactionManagedObject>
}

class TransactionsRepositoryImplementation: TransactionsRepository {
    
    private let stack: CoreDataStack
    
    init(stack: CoreDataStack) {
        self.stack = stack
    }
    
    func allDataFRC() -> NSFetchedResultsController<TransactionManagedObject> {
        let fetchRequest = allDataFetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "creationTimeInterval", ascending: true)]
        return NSFetchedResultsController(fetchRequest: fetchRequest,
                                          managedObjectContext: stack.getViewContext(),
                                          sectionNameKeyPath: nil,
                                          cacheName: nil)
    }
    
    func update(withTransactions transactions: [Transaction]) {
        stack.performBackgroundTask { (context: NSManagedObjectContext) in
            if let storedData = self.getAllData(inContext: context) {
                if let transactionsToDelete = self.filtered(transactions: storedData,
                                                            notIncludedInData: transactions) {
                    self.delete(transactions: transactionsToDelete,
                                fromContext: context)
                }
                self.updateOrCreateNewEntities(basedOnTransactions: transactions,
                                               storedTransactions: storedData,
                                               inContext: context)
            } else {
                self.createNewEntities(basedOnTransactions: transactions, inContext: context)
            }
            
            do {
                try context.save()
            } catch {
                print(error)
            }
        }
    }
    
    func add(transaction: Transaction) {
        let context = stack.getViewContext()
        context.perform {
            let entity = TransactionManagedObject.insertNew(inContext: context)
            self.updateProperties(ofTransactionEntity: entity, withTransaction: transaction)
        }
        
        do {
            try context.save()
        } catch {
            print(error)
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
                transactionEntity = TransactionManagedObject.insertNew(inContext: context)
            }
            
            updateProperties(ofTransactionEntity: transactionEntity, withTransaction: transaction)
        }
    }
    
    private func createNewEntities(basedOnTransactions transactions: [Transaction], inContext context: NSManagedObjectContext) {
        for transaction in transactions {
            let entity = TransactionManagedObject.insertNew(inContext: context)
            updateProperties(ofTransactionEntity: entity, withTransaction: transaction)
        }
    }
    
    private func updateProperties(ofTransactionEntity transactionEntity: TransactionManagedObject,
                                  withTransaction transaction: Transaction) {
        transactionEntity.identifier = transaction.identifier
        transactionEntity.title = transaction.title
        transactionEntity.category = transaction.category
        transactionEntity.value = transaction.value
        transactionEntity.creationTimeInterval = transaction.creationTimeInterval
    }
}
