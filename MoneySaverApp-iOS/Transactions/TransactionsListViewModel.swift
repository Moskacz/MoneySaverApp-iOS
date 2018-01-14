//
//  TransactionsListViewModel.swift
//  MoneySaverApp-iOS
//
//  Created by Michał Moskała on 27.03.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation
import CoreData

class TransactionsListViewModel {
    
    private let transactionsService: TransactionsService
    private var transactionsComputingService: TransactionsComputingService
    private let logger: Logger
    private let calendar: CalendarProtocol
    private let timeChangedObserver: TimeChangedObserver
    
    private var collectionUpdater: CollectionUpdater?
    private var transactionsFRC: NSFetchedResultsController<TransactionManagedObject>?
    private var collectionUpdateHandler: CoreDataCollectionUpdateHandler?
    
    init(transactionsService: TransactionsService,
         transactionsComputingService: TransactionsComputingService,
         logger: Logger,
         calendar: CalendarProtocol,
         timeChangedObserver: TimeChangedObserver) {
        self.transactionsService = transactionsService
        self.transactionsComputingService = transactionsComputingService
        self.logger = logger
        self.calendar = calendar
        self.timeChangedObserver = timeChangedObserver
    }
    
    func summaryViewModel() -> TransactionsSummaryViewModel {
        return TransactionsSummaryViewModel(computingService: transactionsComputingService,
                                            calendar: calendar)
    }
    
    func attach(updater: CollectionUpdater) {
        collectionUpdater = updater
        createCollectionUpdateHandler()
        createFRC()
    }
    
    func sectionsCount() -> Int {
        return transactionsFRC?.sections?.count ?? 0
    }
    
    func transactionsCount(inSection section: Int) -> Int {
        let transactionsSection = transactionsFRC?.sections?[section]
        return transactionsSection?.numberOfObjects ?? 0
    }
    
    func title(forSection section: Int) -> String? {
        guard
            let sectionInfo = transactionsFRC?.sections?[section],
            let transaction = sectionInfo.objects?.first as? TransactionManagedObject else { return nil }
        let date = Date(timeIntervalSince1970: transaction.creationTimeInterval)
        return DateFormatters.formatter(forType: .dateOnly).string(from: date)
    }
    
    func transactionCellViewModel(atPath path: IndexPath) -> TransactionCellViewModel {
        guard let transaction = transactionsFRC?.object(at: path) else { fatalError() }
        return TransactionCellViewModelImplementation(transaction: transaction)
    }
    
    func deleteTransaction(atPath path: IndexPath) {
        guard let transaction = transactionsFRC?.object(at: path) else { return }
        transactionsService.remove(transaction: transaction)
    }
    
    // MARK: Private
    
    private func createCollectionUpdateHandler() {
        guard let updater = collectionUpdater else {
            return
        }
        
        collectionUpdateHandler = CoreDataCollectionUpdateHandler(collectionUpdater: updater)
    }
    
    private func createFRC() {
        transactionsFRC = transactionsService.allDataFRC
        transactionsFRC?.delegate = collectionUpdateHandler
        
        do {
            try transactionsFRC?.performFetch()
            collectionUpdater?.reloadAll()
        } catch {
            logger.log(withLevel: .error, message: error.localizedDescription)
        }
    }
}

extension TransactionsListViewModel: TimeChangedObserverDelegate {
    func timeChanged() {
        collectionUpdater?.reloadAll()
    }
}
