//
//  TransactionsComputingModel.swift
//  MoneySaverApp-iOS
//
//  Created by Michał Moskała on 13.05.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation
import CoreData

protocol TransactionsComputingService  {
    func sum() -> TransactionsCompoundSum
    func monthlyExpensesPerDay() -> [(Int, Decimal)]
    func add(delegate: TransactionsComputingServiceDelegate?)
}

protocol TransactionsComputingServiceDelegate: class {
    func sumUpdated(sum: TransactionsCompoundSum)
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
}

class TransactionsComputingServiceImpl: TransactionsComputingService {
    
    private let repository: TransactionsRepository
    private let notificationCenter: NotificationCenter
    private let calendarService: CalendarService
    private let logger: Logger
    private var delegates = [TransactionsComputingServiceDelegate]()
    
    init(repository: TransactionsRepository,
         notificationCenter: NotificationCenter,
         calendarService: CalendarService,
         logger: Logger) {
        self.repository = repository
        self.notificationCenter = notificationCenter
        self.calendarService = calendarService
        self.logger = logger
        setupNotificationsObservers()
    }
    
    private func setupNotificationsObservers() {
        let notification = Notification.Name.NSManagedObjectContextDidSave
        notificationCenter.addObserver(forName: notification, object: repository.context, queue: OperationQueue.main) { (_) in
            self.notifyDelegates(withSum: self.sum())
        }
    }
    
    func add(delegate: TransactionsComputingServiceDelegate?) {
        if let del = delegate {
            delegates.append(del)
        }
    }
    
    func sum() -> TransactionsCompoundSum {
        return TransactionsCompoundSum(daily: transactionsSum(forDateComponent: .day),
                                       weekly: transactionsSum(forDateComponent: .weekOfYear),
                                       monthly: transactionsSum(forDateComponent: .month),
                                       yearly: transactionsSum(forDateComponent: .year))
    }
    
    private func transactionsSum(forDateComponent component: TransactionDateComponent) -> TransactionsSum {
        let entities = transactions(forDateComponent: component)
        return sum(transactions: entities, dateComponent: component)
    }
    
    private func transactions(forDateComponent component: TransactionDateComponent) -> [TransactionManagedObject] {
        let request = repository.fetchRequest
        request.propertiesToFetch = ["value"]
        request.includesPropertyValues = true
        request.predicate = repository.predicate(forDateComponent: component)
        
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
    
    func monthlyExpensesPerDay() -> [(Int, Decimal)] {
        let request: NSFetchRequest<NSDictionary> = NSFetchRequest(entityName: TransactionManagedObject.entityName)
        request.predicate = repository.predicate(forDateComponent: .month)
        
        let expressionDesc = NSExpressionDescription()
        expressionDesc.expression = NSExpression(forFunction: "sum:", arguments: [NSExpression(forKeyPath: "value")])
        expressionDesc.name = "sum"
        expressionDesc.expressionResultType = .decimalAttributeType
        request.propertiesToFetch = [expressionDesc, "day"]
        request.propertiesToGroupBy = ["day"]
        request.resultType = .dictionaryResultType
        
        do {
            let dictionaries = try repository.context.fetch(request)
            return dictionaries.flatMap {
                guard let day = $0["day"] as? Int, let sum = $0["sum"] as? Decimal else { return nil }
                return (day, sum)
            }
        } catch {
           return []
        }
    }
    
    private func notifyDelegates(withSum sum: TransactionsCompoundSum) {
        for delegate in delegates {
            delegate.sumUpdated(sum: sum)
        }
    }
    
}
