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
}

class TransactionsRepositoryImplementation: TransactionsRepository {
    
    private let stack: CoreDataStack
    
    init(stack: CoreDataStack) {
        self.stack = stack
    }
    
    func update(withTransactions transactions: [Transaction]) {
        let context = stack.getBackgroundContext()
        context.perform {
            self.deleteAllEntities(inContext: context)
            self.createNewEntities(basedOnTransactions: transactions, inContext: context)
            do {
                try context.save()
            } catch {
                print(error)
            }
        }
    }
    
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
    
    private func deleteAllEntities(inContext context: NSManagedObjectContext) {
        guard let storedEntities = getAllData(inContext: context) else {
            return
        }
        
        for entity in storedEntities {
            context.delete(entity)
        }
    }
    
    private func createNewEntities(basedOnTransactions transactions: [Transaction], inContext context: NSManagedObjectContext) {
        for transaction in transactions {
            let entity = TransactionManagedObject.insertNew(inContext: context)
            entity.title = transaction.title
            entity.category = transaction.category
            entity.value = transaction.value
        }
    }
}
