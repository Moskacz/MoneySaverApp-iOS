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
    
    private let repository: TransactionsRepository
    private var transactionsComputingService: TransactionsComputingService
    private let logger: Logger
    private let calendar: CalendarProtocol
    private let timeChangedObserver: TimeChangedObserver
    private let appPreservationModel: AppPreservationModel
    
    private var collectionUpdater: CollectionUpdater?
    private var transactionsFRC: NSFetchedResultsController<TransactionManagedObject>?
    private var collectionUpdateHandler: CoreDataCollectionUpdateHandler?
    
    init(repository: TransactionsRepository,
         transactionsComputingService: TransactionsComputingService,
         logger: Logger,
         calendar: CalendarProtocol,
         timeChangedObserver: TimeChangedObserver,
         appPreservationModel: AppPreservationModel) {
        self.repository = repository
        self.transactionsComputingService = transactionsComputingService
        self.logger = logger
        self.calendar = calendar
        self.timeChangedObserver = timeChangedObserver
        self.appPreservationModel = appPreservationModel
        self.timeChangedObserver.delegate = self
    }
    
    func attach(updater: CollectionUpdater) {
        collectionUpdater = updater
        createFRC(withUpdater: updater)
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
            let transaction = sectionInfo.objects?.first as? TransactionManagedObject,
            let timeInterval = transaction.date?.timeInterval
        else { return nil }
        let date = Date(timeIntervalSince1970: timeInterval)
        return DateFormatters.formatter(forType: .dateOnly).string(from: date)
    }
    
    func transactionCellViewModel(atPath path: IndexPath) -> TransactionCellViewModel {
        guard let transaction = transactionsFRC?.object(at: path) else { fatalError() }
        return TransactionCellViewModelImplementation(transaction: transaction)
    }
    
    func deleteTransaction(atPath path: IndexPath) {
        guard let transaction = transactionsFRC?.object(at: path) else { return }
        repository.remove(transaction: transaction)
    }
    
    var dateRangeFilter: DateRange {
        return appPreservationModel.savedDateRangeFilter ?? DateRange.allTime
    }
    
    // MARK: Private
    
    private func createFRC(withUpdater updater: CollectionUpdater) {
        transactionsFRC = repository.allTransactionsFRC
        setupPredicate(forDateRange: dateRangeFilter)
        collectionUpdateHandler = CoreDataCollectionUpdateHandler(collectionUpdater: updater)
        transactionsFRC?.delegate = collectionUpdateHandler
        fetchData()
    }
    
    private func fetchData() {
        guard collectionUpdater != nil else { return }
        do {
            try transactionsFRC?.performFetch()
            collectionUpdater?.reloadAll()
        } catch {
            logger.log(withLevel: .error, message: error.localizedDescription)
        }
    }
    
    private func setupPredicate(forDateRange dateRange: DateRange) {
        transactionsFRC?.fetchRequest.predicate = repository.predicate(forDateRange: dateRange)
    }
}

extension TransactionsListViewModel: TimeChangedObserverDelegate {
    func timeChanged() {
        fetchData()
    }
}
