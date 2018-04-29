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
import MoneySaverAppCore

protocol TransactionsComputingService {
    func sum() throws -> TransactionsCompoundSum
    func observeTransactionsSumChanged(_ callback: @escaping (TransactionsCompoundSum) -> Void) -> ObservationToken
    
    func monthlyExpenses() throws -> [DatedValue]
    func observeMonthlyExpenseChanged(_ callback: @escaping ([DatedValue]) -> Void) -> ObservationToken
}

class TransactionsComputingServiceImpl: TransactionsComputingService {
    
    private let repository: TransactionsRepository
    private let calendar: CalendarProtocol
    private let notificationCenter: NotificationCenter
    private let logger: Logger
    private let timeChangedObserver: TimeChangedObserver
    var delegates = WeakArray<AnyObject>()
    
    init(repository: TransactionsRepository,
         calendar: CalendarProtocol,
         notificationCenter: NotificationCenter,
         logger: Logger,
         timeChangedObserver: TimeChangedObserver) {
        self.repository = repository
        self.calendar = calendar
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
        let date = calendar.nowCalendarDate
        return try repository.allTransactions().compoundSum(date: date)
    }
    
    func observeTransactionsSumChanged(_ callback: @escaping (TransactionsCompoundSum) -> Void) -> ObservationToken {
        let token = notificationCenter.addObserver(forName: .sumChangedNotification, object: nil, queue: .main, using: { (note) in
            guard let sum = note.userInfo?["TransactionsCompoundSum"] as? TransactionsCompoundSum else {
                return
            }
            callback(sum)
        })
        return ObservationToken(notificationCenter: notificationCenter, token: token)
    }
    
    func monthlyExpenses() throws -> [DatedValue] {
        let request: NSFetchRequest<TransactionManagedObject> = TransactionManagedObject.fetchRequest()
        let predicates = [repository.expensesOnlyPredicate, repository.predicate(forDateRange: .thisMonth)].compactMap { $0 }
        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
        
        let groupedTransactions = try repository.context.fetch(request).filter { $0.date != nil}.grouped { $0.date!.dayOfMonth }
        
        return groupedTransactions.map{ (dayOfEra, transactions) -> DatedValue in
            let values = transactions.map { $0.value?.doubleValue ?? 0 }
            return DatedValue(date: Int(dayOfEra), value: Decimal(values.reduce(0, +)))
        }
    }
    
    func observeMonthlyExpenseChanged(_ callback: @escaping ([DatedValue]) -> Void) -> ObservationToken {
        let token = notificationCenter.addObserver(forName: .monthlyExpensesChangedNotification, object: nil, queue: .main, using: { note in
            guard let values = note.userInfo?["DatedValue"] as? [DatedValue] else {
                return
            }
            callback(values)
        })
        return ObservationToken(notificationCenter: notificationCenter, token: token)
    }
    
    private func notifyDelegates() {
        do {
            let transactionsSum = try sum()
            notificationCenter.post(name: .sumChangedNotification, object: nil, userInfo: ["TransactionsCompoundSum": transactionsSum])
            let expenses = try monthlyExpenses()
            notificationCenter.post(name: .monthlyExpensesChangedNotification, object: nil, userInfo: ["DatedValue": expenses])
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
