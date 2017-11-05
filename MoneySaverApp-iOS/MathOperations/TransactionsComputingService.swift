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
    var delegate: TransactionsComputingServiceDelegate? { get set }
    func transactionsSum(sum: @escaping (CompoundTransactionsSum) -> Void)
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

    private let coreDataStack: CoreDataStack
    private let notificationCenter: NotificationCenter
    private let dateIntervalService: DateIntervalService
    private let logger: Logger
    
    weak var delegate: TransactionsComputingServiceDelegate?
    
    init(coreDataStack: CoreDataStack,
         notificationCenter: NotificationCenter,
         dateIntervalService: DateIntervalService,
         logger: Logger) {
        self.coreDataStack = coreDataStack
        self.notificationCenter = notificationCenter
        self.dateIntervalService = dateIntervalService
        self.logger = logger
        setupNotificationsObservers()
    }
    
    private func setupNotificationsObservers() {
        coreDataStack.getViewContext { (context) in
            let notification = Notification.Name.NSManagedObjectContextDidSave
            self.notificationCenter.addObserver(forName: notification, object: context, queue: OperationQueue.main) { (_) in
                self.delegate?.sumUpdated(value: self.totalValueOfSavedTransactions(inContext: context))
            }
        }
    }
    
    func transactionsSum(sum: @escaping (CompoundTransactionsSum) -> Void) {
        coreDataStack.getViewContext { (context) in
            sum(self.totalValueOfSavedTransactions(inContext: context))
        }
    }
    
    private func totalValueOfSavedTransactions(inContext context: NSManagedObjectContext) -> CompoundTransactionsSum {
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
        guard let dateInterval = dateIntervalService.dateInterval(forType: type) else {
            return []
        }
        
        return transactions.filter {
            dateInterval.contains(Date(timeIntervalSince1970: $0.creationTimeInterval))
        }
    }
}
