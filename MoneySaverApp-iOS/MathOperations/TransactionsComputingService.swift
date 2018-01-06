//
//  TransactionsComputingModel.swift
//  MoneySaverApp-iOS
//
//  Created by Michał Moskała on 13.05.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation
import CoreData
import MMFoundation

struct DailyValue {
    let day: Int
    let value: Decimal
}

protocol TransactionsComputingService {
    var delegates: WeakArray<AnyObject> { get }
    func sum() -> TransactionsCompoundSum
    func monthlyExpenses() -> [DailyValue]
}

protocol TransactionsComputingServiceDelegate {
    func transactionsSumUpdated(_ sum: TransactionsCompoundSum)
    func monthlyExpensesUpdated(_ expenses: [DailyValue])
}

struct TransactionsSum {
    let incomes: Decimal
    let expenses: Decimal
    let dateComponent: TransactionDateComponent
    
    func total() -> Decimal {
        return incomes + expenses
    }
}

struct TransactionsCompoundSum {
    let daily: TransactionsSum
    let weekly: TransactionsSum
    let monthly: TransactionsSum
    let yearly: TransactionsSum
    let era: TransactionsSum
}

class TransactionsComputingServiceImpl: TransactionsComputingService {
    
    private let repository: TransactionsRepository
    private let notificationCenter: NotificationCenter
    private let calendarService: CalendarService
    private let logger: Logger
    private let timeChangedObserver: TimeChangedObserver
    var delegates = WeakArray<AnyObject>()
    
    init(repository: TransactionsRepository,
         notificationCenter: NotificationCenter,
         calendarService: CalendarService,
         logger: Logger,
         timeChangedObserver: TimeChangedObserver) {
        self.repository = repository
        self.notificationCenter = notificationCenter
        self.calendarService = calendarService
        self.logger = logger
        self.timeChangedObserver = timeChangedObserver
        setupNotificationsObservers()
        self.timeChangedObserver.delegate = self
    }
    
    private func setupNotificationsObservers() {
        let notification = Notification.Name.NSManagedObjectContextDidSave
        notificationCenter.addObserver(forName: notification, object: repository.context, queue: OperationQueue.main) { (_) in
            self.notifyDelegates()
        }
    }
    
    func sum() -> TransactionsCompoundSum {
        return TransactionsCompoundSum(daily: transactionsSum(forDateComponent: .dayOfEra),
                                       weekly: transactionsSum(forDateComponent: .weekOfYear),
                                       monthly: transactionsSum(forDateComponent: .month),
                                       yearly: transactionsSum(forDateComponent: .year),
                                       era: transactionsSum(forDateComponent: .era))
    }
    
    private func transactionsSum(forDateComponent component: TransactionDateComponent) -> TransactionsSum {
        let entities = transactions(forDateComponent: component)
        return sum(transactions: entities, dateComponent: component)
    }
    
    private func transactions(forDateComponent component: TransactionDateComponent) -> [TransactionManagedObject] {
        let request = repository.fetchRequest
        request.propertiesToFetch = [TransactionManagedObject.AttributesNames.value.rawValue]
        request.includesPropertyValues = true
        if component != .era {
            let predicates = [repository.predicate(forDateComponent: component), repository.currentYearOnlyPredicate]
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
        }
        
        do {
            return try repository.context.fetch(request)
        } catch {
            logger.log(withLevel: .error, message: error.localizedDescription)
            return []
        }
    }
    
    private func sum(transactions: [TransactionManagedObject], dateComponent: TransactionDateComponent) -> TransactionsSum {
        let values = transactions.map { $0.value?.doubleValue ?? 0 }
        let incomes = values.filter { $0 > 0 }.reduce(0, +)
        let expenses = values.filter { $0 < 0 }.reduce(0, +)
        return TransactionsSum(incomes: Decimal(incomes),
                               expenses: Decimal(expenses),
                               dateComponent: dateComponent)
    }
    
    func monthlyExpenses() -> [DailyValue] {
        let request: NSFetchRequest<NSDictionary> = NSFetchRequest(entityName: TransactionManagedObject.entityName)
        let predicates = [repository.expensesOnlyPredicate, repository.predicate(forDateComponent: .month)]
        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
        
        let expressionDesc = NSExpressionDescription()
        let expressionName = "sum"
        expressionDesc.expression = NSExpression(forFunction: "sum:",
                                                 arguments: [NSExpression(forKeyPath: TransactionManagedObject.AttributesNames.value.rawValue)])
        expressionDesc.name = expressionName
        expressionDesc.expressionResultType = .decimalAttributeType
        
        request.propertiesToFetch = [expressionDesc, TransactionManagedObject.AttributesNames.dayOfMonth.rawValue]
        request.propertiesToGroupBy = [TransactionManagedObject.AttributesNames.dayOfMonth.rawValue]
        request.resultType = .dictionaryResultType
        
        do {
            let dictionaries = try repository.context.fetch(request)
            return dictionaries.flatMap {
                guard let day = $0[TransactionManagedObject.AttributesNames.dayOfMonth.rawValue] as? Int,
                    let sum = $0[expressionName] as? Decimal else { return nil }
                return DailyValue(day: day, value: sum)
            }
        } catch {
            return []
        }
    }
    
    private func notifyDelegates() {
        let transactionsSum = sum()
        let expenses = monthlyExpenses()
        for object in delegates {
            let delegate = object as? TransactionsComputingServiceDelegate
            delegate?.transactionsSumUpdated(transactionsSum)
            delegate?.monthlyExpensesUpdated(expenses)
        }
    }
    
}

extension TransactionsComputingServiceImpl: TimeChangedObserverDelegate {
    func timeChanged() {
        notifyDelegates()
    }
}
