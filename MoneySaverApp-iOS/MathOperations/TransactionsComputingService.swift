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
    static let storageKey = "valueStorageKey"
    
    let day: Int
    let value: Decimal
}

protocol TransactionsComputingService {
    func sum() throws -> TransactionsCompoundSum
    func observeTransactionsSumChanged(_ callback: @escaping (TransactionsCompoundSum) -> Void) -> ObservationToken
    
    func monthlyExpenses() throws -> [DailyValue]
    func observeMonthlyExpenseChanged(_ callback: @escaping ([DailyValue]) -> Void) -> ObservationToken
}

struct TransactionsSum {
    let incomes: Decimal
    let expenses: Decimal
    let dateRange: DateRange
    
    func total() -> Decimal {
        return incomes + expenses
    }
}

struct TransactionsCompoundSum {
    static let storageKey = "sumStorageKey"
    
    let daily: TransactionsSum
    let weekly: TransactionsSum
    let monthly: TransactionsSum
    let yearly: TransactionsSum
    let era: TransactionsSum
}

class TransactionsComputingServiceImpl: TransactionsComputingService {
    
    private let repository: TransactionsRepository
    private let notificationCenter: NotificationCenter
    private let logger: Logger
    private let timeChangedObserver: TimeChangedObserver
    var delegates = WeakArray<AnyObject>()
    
    init(repository: TransactionsRepository,
         notificationCenter: NotificationCenter,
         logger: Logger,
         timeChangedObserver: TimeChangedObserver) {
        self.repository = repository
        self.notificationCenter = notificationCenter
        self.logger = logger
        self.timeChangedObserver = timeChangedObserver
        setupNotificationsObservers()
        self.timeChangedObserver.delegate = self
    }
    
    private func setupNotificationsObservers() {
        let notification = Notification.Name.NSManagedObjectContextObjectsDidChange
        notificationCenter.addObserver(forName: notification, object: repository.context, queue: OperationQueue.main) { [weak self] (_) in
            self?.notifyDelegates()
        }
    }
    
    func sum() throws -> TransactionsCompoundSum {
        return TransactionsCompoundSum(daily: try transactionsSum(forDateRange: .today),
                                       weekly: try transactionsSum(forDateRange: .thisWeek),
                                       monthly: try transactionsSum(forDateRange: .thisMonth),
                                       yearly: try transactionsSum(forDateRange: .thisYear),
                                       era: try transactionsSum(forDateRange: .allTime))
    }
    
    private func transactionsSum(forDateRange range: DateRange) throws -> TransactionsSum {
        let entities = try transactions(forDateRange: range)
        return sum(transactions: entities, dateRange: range)
    }
    
    private func transactions(forDateRange range: DateRange) throws -> [TransactionProtocol] {
        let request = repository.fetchRequest
        request.propertiesToFetch = [TransactionManagedObject.KeyPaths.value.rawValue]
        request.includesPropertyValues = true
        request.predicate = repository.predicate(forDateRange: range)
        return try repository.context.fetch(request)
    }
    
    private func sum(transactions: [TransactionProtocol], dateRange: DateRange) -> TransactionsSum {
        let values = transactions.map { $0.value?.doubleValue ?? 0 }
        let incomes = values.filter { $0 > 0 }.reduce(0, +)
        let expenses = values.filter { $0 < 0 }.reduce(0, +)
        return TransactionsSum(incomes: Decimal(incomes),
                               expenses: Decimal(expenses),
                               dateRange: dateRange)
    }
    
    func observeTransactionsSumChanged(_ callback: @escaping (TransactionsCompoundSum) -> Void) -> ObservationToken {
        let token = notificationCenter.addObserver(forName: .sumChangedNotification, object: nil, queue: .main, using: { (note) in
            guard let sum = note.userInfo?[TransactionsCompoundSum.storageKey] as? TransactionsCompoundSum else {
                return
            }
            callback(sum)
        })
        return ObservationToken(notificationCenter: notificationCenter, token: token)
    }
    
    func monthlyExpenses() throws -> [DailyValue] {
        let request: NSFetchRequest<TransactionManagedObject> = TransactionManagedObject.fetchRequest()
        let predicates = [repository.expensesOnlyPredicate, repository.predicate(forDateRange: .thisMonth)].flatMap { $0 }
        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
        let groupedTransactions = try repository.context.fetch(request).filter { $0.date != nil}.grouped { $0.date!.dayOfMonth }
        return groupedTransactions.map{ (dayOfEra, transactions) -> DailyValue in
            let values = transactions.map { $0.value?.doubleValue ?? 0 }
            return DailyValue(day: Int(dayOfEra), value: Decimal(values.reduce(0, +)))
        }
    }
    
    func observeMonthlyExpenseChanged(_ callback: @escaping ([DailyValue]) -> Void) -> ObservationToken {
        let token = notificationCenter.addObserver(forName: .monthlyExpensesChangedNotification, object: nil, queue: .main, using: { note in
            guard let values = note.userInfo?[DailyValue.storageKey] as? [DailyValue] else {
                return
            }
            callback(values)
        })
        return ObservationToken(notificationCenter: notificationCenter, token: token)
    }
    
    private func notifyDelegates() {
        do {
            let transactionsSum = try sum()
            notificationCenter.post(name: .sumChangedNotification, object: nil, userInfo: [TransactionsCompoundSum.storageKey: transactionsSum])
            let expenses = try monthlyExpenses()
            notificationCenter.post(name: .monthlyExpensesChangedNotification, object: nil, userInfo: [DailyValue.storageKey: expenses])
        } catch {
            logger.log(withLevel: .error, message: error.localizedDescription)
        }
    }
}

extension TransactionsComputingServiceImpl: TimeChangedObserverDelegate {
    func timeChanged() {
        notifyDelegates()
    }
}
