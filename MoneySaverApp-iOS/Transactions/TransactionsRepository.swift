//
//  TransactionRepository.swift
//  MoneySaverApp-iOS
//
//  Created by Michał Moskała on 15.04.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation
import CoreData

protocol TransactionsRepository {
    var allTransactionsFRC: NSFetchedResultsController<TransactionManagedObject> { get }
    var context: NSManagedObjectContext { get }
    var fetchRequest: NSFetchRequest<TransactionManagedObject> { get }
    var expensesOnlyPredicate: NSPredicate { get }
    
    func predicate(forDateRange range: DateRange) -> NSPredicate?
    func addTransaction(data: TransactionData, category: TransactionCategoryManagedObject)
    func remove(transaction: TransactionManagedObject)
    
    func allTransactions() throws -> [TransactionManagedObject]
    func groupedTransactions(grouping: TransactionsGrouping) throws -> [DatedValue]
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
    
    var allTransactionsFRC: NSFetchedResultsController<TransactionManagedObject> {
        let request = fetchRequest
        request.includesPropertyValues = true
        request.fetchBatchSize = 20
        
        request.sortDescriptors = [NSSortDescriptor(key: TransactionManagedObject.KeyPath.dayOfEra.rawValue, ascending: false),
                                   NSSortDescriptor(key: TransactionManagedObject.KeyPath.timeInterval.rawValue, ascending: false)]
        
        return NSFetchedResultsController(fetchRequest: request,
                                          managedObjectContext: context,
                                          sectionNameKeyPath: TransactionManagedObject.KeyPath.dayOfEra.rawValue,
                                          cacheName: nil)
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
        let date = calendar.now
        switch range {
        case .today:
            return NSPredicate(format: "\(TransactionManagedObject.KeyPath.dayOfEra.rawValue) == \(calendar.dayOfEraOf(date: date))")
        case .thisWeek:
            return NSPredicate(format: "\(TransactionManagedObject.KeyPath.weekOfEra.rawValue) == \(calendar.weekOfEraOf(date: date))")
        case .thisMonth:
            return NSPredicate(format: "\(TransactionManagedObject.KeyPath.monthOfEra.rawValue) == \(calendar.monthOfEraOf(date: date))")
        case .thisYear:
            return NSPredicate(format: "\(TransactionManagedObject.KeyPath.year.rawValue) == \(calendar.yearOf(date: date))")
        case .allTime:
            return nil
        }
    }
    
    func addTransaction(data: TransactionData, category: TransactionCategoryManagedObject) {
        context.perform {
            let transaction = TransactionManagedObject.createEntity(inContext: self.context)
            transaction.title = data.title
            transaction.value = data.value as NSDecimalNumber
            let date = CalendarDateManagedObject.createEntity(inContext: self.context)
            date.update(with: self.calendar.nowCalendarDate)
            transaction.date = date
            transaction.category = category
        }
    }
    
    func remove(transaction: TransactionManagedObject) {
        context.delete(transaction)
    }
    
    func allTransactions() throws -> [TransactionManagedObject] {
        let request = fetchRequest
        request.includesPropertyValues = true
        return try context.fetch(request)
    }
    
    func groupedTransactions(grouping: TransactionsGrouping) throws -> [DatedValue] {
        let request = NSFetchRequest<NSDictionary>.init(entityName: TransactionManagedObject.entityName)
        
        let valueExpression = NSExpression(forKeyPath: TransactionManagedObject.KeyPath.value.rawValue)
        let sumExpressionDesc = NSExpressionDescription()
        sumExpressionDesc.expression = NSExpression(forFunction: "sum:", arguments: [valueExpression])
        sumExpressionDesc.name = "sum"
        sumExpressionDesc.expressionResultType = .doubleAttributeType
        
        request.propertiesToFetch = [TransactionManagedObject.KeyPath.dayOfEra.rawValue,
                                     sumExpressionDesc]
        request.propertiesToGroupBy = [TransactionManagedObject.KeyPath.dayOfEra.rawValue]
        request.resultType = .dictionaryResultType
        
        let objects = try context.fetch(request)
        return objects.compactMap { dict -> DatedValue? in
            guard
                let sum = dict["sum"] as? Double,
                let date = dict[TransactionManagedObject.KeyPath.dayOfEra.rawValue] as? Int else {
                return nil
            }
            
            return DatedValue(date: date, value: Decimal(sum))
        }
    }
}
