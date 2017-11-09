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
    func allDataFRC(completion: @escaping ((NSFetchedResultsController<TransactionManagedObject>) -> Void))
    func addTransaction(data: TransactionData, category: TransactionCategoryManagedObject)
    func remove(transaction: TransactionManagedObject)
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
            let fetchRequest: NSFetchRequest<TransactionManagedObject> = TransactionManagedObject.fetchRequest()
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "creationTimeInterval", ascending: true)]
            let frc = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                 managedObjectContext: context,
                                                 sectionNameKeyPath: nil,
                                                 cacheName: nil)
            completion(frc)
        }
    }
    
    func addTransaction(data: TransactionData, category: TransactionCategoryManagedObject) {
        stack.getViewContext { [weak self] (context) in
            context.perform {
                let transaction = TransactionManagedObject.createEntity(inContext: context)
                transaction.value = data.value as NSDecimalNumber
                transaction.title = data.title
                transaction.category = category
                transaction.creationTimeInterval = Date().timeIntervalSince1970
                self?.saveContextIfNeeded(context)
            }
        }
    }
    
    func remove(transaction: TransactionManagedObject) {
        stack.getViewContext { [weak self] (context) in
            context.delete(transaction)
            self?.saveContextIfNeeded(context)
        }
    }
    
    private func saveContextIfNeeded(_ context: NSManagedObjectContext) {
        guard context.hasChanges else { return }
        do {
            try context.save()
        } catch {
            logger.log(withLevel: .error, message: error.localizedDescription)
        }
    }
}
