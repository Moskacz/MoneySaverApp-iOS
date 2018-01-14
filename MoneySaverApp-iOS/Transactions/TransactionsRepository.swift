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
    
    func predicate(forDateRange range: DateRange) -> NSPredicate?
    func addTransaction(data: TransactionData, category: TransactionCategoryManagedObject)
    func remove(transaction: TransactionManagedObject)
}

class TransactionsRepositoryImplementation: TransactionsRepository {
    
    let context: NSManagedObjectContext
    private let calendar: CalendarProtocol
    private let logger: Logger
    
    init(context: NSManagedObjectContext,
         logger: Logger,
         calendar: CalendarProtocol) {
        self.context = context
        self.logger = logger
        self.calendar = calendar
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
    
    func predicate(forDateRange range: DateRange) -> NSPredicate? {
        let date = calendar.structuredDate(forDate: calendar.now)
        switch range {
        case .today:
            return NSPredicate(format: "\(TransactionManagedObject.AttributesNames.dayOfEra) == \(date.dayOfEra)")
        case .thisWeek:
            return NSPredicate(format: "\(TransactionManagedObject.AttributesNames.weekOfEra) == \(date.weekOfEra)")
        case .thisMonth:
            return NSPredicate(format: "\(TransactionManagedObject.AttributesNames.monthOfEra) == \(date.monthOfEra)")
        case .thisYear:
            return NSPredicate(format: "\(TransactionManagedObject.AttributesNames.year) == \(date.year)")
        case .allTime:
            return nil
        }
    }
    
    func addTransaction(data: TransactionData, category: TransactionCategoryManagedObject) {
        context.perform {
            let transaction = TransactionManagedObject.createEntity(inContext: self.context)
            transaction.title = data.title
            transaction.value = data.value as NSDecimalNumber
            transaction.setupDateComponents(date: self.calendar.structuredDate(forDate: data.creationDate))
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
