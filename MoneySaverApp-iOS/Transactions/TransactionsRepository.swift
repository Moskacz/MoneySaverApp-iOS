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
    func allDataFRC() -> NSFetchedResultsController<TransactionManagedObject>
    func addTransaction(data: TransactionData, category: TransactionCategoryManagedObject)
    func remove(transaction: TransactionManagedObject)
}

class TransactionsRepositoryImplementation: TransactionsRepository {
    
    private let context: NSManagedObjectContext
    private let calendarService: CalendarService
    private let logger: Logger
    
    init(context: NSManagedObjectContext,
         logger: Logger,
         calendarService: CalendarService) {
        self.context = context
        self.logger = logger
        self.calendarService = calendarService
    }
    
    func allDataFRC() -> NSFetchedResultsController<TransactionManagedObject> {
        let fetchRequest: NSFetchRequest<TransactionManagedObject> = TransactionManagedObject.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "creationTimeInterval", ascending: false)]
        
        return NSFetchedResultsController(fetchRequest: fetchRequest,
                                          managedObjectContext: context,
                                          sectionNameKeyPath: "dayOfYear",
                                          cacheName: nil)
    }
    
    func addTransaction(data: TransactionData, category: TransactionCategoryManagedObject) {
        context.perform {
            let transaction = TransactionManagedObject.createEntity(inContext: self.context)
            transaction.creationTimeInterval = data.creationDate.timeIntervalSince1970
            transaction.day = Int32(self.calendarService.day(ofDate: data.creationDate))
            transaction.dayOfYear = Int32(self.calendarService.dayOfYear(ofDate: data.creationDate))
            transaction.month = Int32(self.calendarService.month(ofDate: data.creationDate))
            transaction.title = data.title
            transaction.value = data.value as NSDecimalNumber
            transaction.weekOfYear = Int32(self.calendarService.weekOfYear(ofDate: data.creationDate))
            transaction.year = Int32(self.calendarService.year(ofDate: data.creationDate))
            transaction.category = category
            self.saveContextIfNeeded()
        }
    }
    
    func remove(transaction: TransactionManagedObject) {
        context.delete(transaction)
        saveContextIfNeeded()
    }
    
    private func saveContextIfNeeded() {
        guard context.hasChanges else { return }
        do {
            try context.save()
        } catch {
            logger.log(withLevel: .error, message: error.localizedDescription)
        }
    }
}
