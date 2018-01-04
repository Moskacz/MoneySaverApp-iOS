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
    var context: NSManagedObjectContext { get }
    var fetchRequest: NSFetchRequest<TransactionManagedObject> { get }
    var expensesOnlyPredicate: NSPredicate { get }
    var currentYearOnlyPredicate: NSPredicate { get }
    
    func predicate(forDateComponent component: TransactionDateComponent) -> NSPredicate
    func addTransaction(data: TransactionData, category: TransactionCategoryManagedObject)
    func remove(transaction: TransactionManagedObject)
}

class TransactionsRepositoryImplementation: TransactionsRepository {
    
    let context: NSManagedObjectContext
    private let calendarService: CalendarService
    private let logger: Logger
    
    init(context: NSManagedObjectContext,
         logger: Logger,
         calendarService: CalendarService) {
        self.context = context
        self.logger = logger
        self.calendarService = calendarService
    }
    
    var fetchRequest: NSFetchRequest<TransactionManagedObject> {
        get {
            return TransactionManagedObject.fetchRequest()
        }
    }
    
    var expensesOnlyPredicate: NSPredicate {
        get {
            return NSPredicate(format: "value < 0")
        }
    }
    
    var currentYearOnlyPredicate: NSPredicate {
        get {
            return predicate(forDateComponent: .year)
        }
    }
    
    func predicate(forDateComponent component: TransactionDateComponent) -> NSPredicate {
        return NSPredicate(format: "\(component.rawValue) == \(calendarService.component(component, ofDate: Date()))")
    }
    
    func addTransaction(data: TransactionData, category: TransactionCategoryManagedObject) {
        context.perform {
            let transaction = TransactionManagedObject.createEntity(inContext: self.context)
            transaction.creationTimeInterval = data.creationDate.timeIntervalSince1970
            transaction.dayOfWeek = Int32(self.calendarService.component(.dayOfWeek, ofDate: data.creationDate))
            transaction.dayOfMonth = Int32(self.calendarService.component(.dayOfMonth, ofDate: data.creationDate))
            transaction.dayOfYear = Int32(self.calendarService.component(.dayOfYear, ofDate: data.creationDate))
            transaction.dayOfEra = Int32(self.calendarService.component(.dayOfEra, ofDate: data.creationDate))
            transaction.month = Int32(self.calendarService.component(.month, ofDate: data.creationDate))
            transaction.title = data.title
            transaction.value = data.value as NSDecimalNumber
            transaction.weekOfYear = Int32(self.calendarService.component(.weekOfYear, ofDate: data.creationDate))
            transaction.year = Int32(self.calendarService.component(.year, ofDate: data.creationDate))
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
