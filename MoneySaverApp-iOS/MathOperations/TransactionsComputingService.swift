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
    func add(delegate: TransactionsComputingServiceDelegate?)
    func transactionsSum() -> CompoundTransactionsSum
}

protocol TransactionsComputingServiceDelegate: class {
    func sumUpdated(value: CompoundTransactionsSum)
}

struct CompoundTransactionsSum {
    let todaySum: Decimal
    let weekSum: Decimal
    let monthSum: Decimal
    let yearSum: Decimal
    
    static var zero: CompoundTransactionsSum {
        return CompoundTransactionsSum(todaySum: 0, weekSum: 0, monthSum: 0, yearSum: 0)
    }
    
    func sum(forDateInterval type: DateIntervalType) -> Decimal {
        switch type {
        case .today:
            return todaySum
        case .currentWeek:
            return weekSum
        case .currentMonth:
            return monthSum
        case .currentYear:
            return yearSum
        }
    }
}

class TransactionsComputingServiceImpl: TransactionsComputingService {

    private let context: NSManagedObjectContext
    private let notificationCenter: NotificationCenter
    private let calendarService: CalendarService
    private let logger: Logger
    private var delegates = [TransactionsComputingServiceDelegate]()
    
    init(context: NSManagedObjectContext,
         notificationCenter: NotificationCenter,
         calendarService: CalendarService,
         logger: Logger) {
        self.context = context
        self.notificationCenter = notificationCenter
        self.calendarService = calendarService
        self.logger = logger
        setupNotificationsObservers()
    }
    
    private func setupNotificationsObservers() {
        let notification = Notification.Name.NSManagedObjectContextDidSave
        notificationCenter.addObserver(forName: notification, object: context, queue: OperationQueue.main) { (_) in
            self.notifyDelegate(withSum: self.transactionsSum())
        }
    }
    
    func add(delegate: TransactionsComputingServiceDelegate?) {
        guard let delegate = delegate else { return }
        delegates.append(delegate)
    }
    
    func transactionsSum() -> CompoundTransactionsSum {
        let fetchRequest: NSFetchRequest<TransactionManagedObject> = TransactionManagedObject.fetchRequest()
        fetchRequest.propertiesToFetch = [TransactionManagedObject.valueAttributeName,
                                          TransactionManagedObject.creationTimeIntervalAttributeName]
        fetchRequest.includesPropertyValues = true
        
        do {
            let transactions = try context.fetch(fetchRequest)
            return compoundSum(fromTransactions: transactions)
        } catch {
            logger.log(withLevel: .error, message: error.localizedDescription)
            return CompoundTransactionsSum.zero
        }
    }
    
    private func compoundSum(fromTransactions transactions: [TransactionManagedObject]) -> CompoundTransactionsSum {
        let year = value(ofTransactions: filteredTransactions(transactions, forDateInterval: .currentYear))
        let month = value(ofTransactions: filteredTransactions(transactions, forDateInterval: .currentMonth))
        let week = value(ofTransactions: filteredTransactions(transactions, forDateInterval: .currentWeek))
        let today = value(ofTransactions: filteredTransactions(transactions, forDateInterval: .today))
        return CompoundTransactionsSum(todaySum: today, weekSum: week, monthSum: month, yearSum: year)
    }
    
    private func value(ofTransactions transactions: [TransactionManagedObject]) -> Decimal {
        return transactions.reduce(Decimal(0), { (result, transaction) -> Decimal in
            let transactionValue = (transaction.value ?? NSDecimalNumber.zero) as Decimal
            return result + transactionValue
        })
    }
    
    private func filteredTransactions(_ transactions: [TransactionManagedObject],
                                      forDateInterval type: DateIntervalType) -> [TransactionManagedObject] {
        guard let dateInterval = calendarService.dateInterval(forType: type) else {
            return []
        }
        
        return transactions.filter {
            dateInterval.contains(Date(timeIntervalSince1970: $0.creationTimeInterval))
        }
    }
    
    private func notifyDelegate(withSum sum: CompoundTransactionsSum) {
        for delegate in delegates {
            delegate.sumUpdated(value: sum)
        }
    }
}
