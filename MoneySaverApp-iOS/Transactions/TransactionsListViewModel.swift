//
//  TransactionsListViewModel.swift
//  MoneySaverApp-iOS
//
//  Created by Michał Moskała on 27.03.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation
import MoneySaverFoundationiOS
import CoreData

class TransactionsListViewModel {
    
    private let transactionsService: TransactionsService
    private var transactionsComputingService: TransactionsComputingService
    private let logger: Logger
    
    private var collectionUpdater: CollectionUpdater?
    private var transactionsFRC: NSFetchedResultsController<TransactionManagedObject>?
    private var collectionUpdateHandler: CoreDataCollectionUpdateHandler?
    
    init(transactionsService: TransactionsService,
         transactionsComputingService: TransactionsComputingService,
         logger: Logger) {
        self.transactionsService = transactionsService
        self.transactionsComputingService = transactionsComputingService
        self.logger = logger
    }
    
    func dateIntervalsPickerViewModel() -> DateIntervalPickerViewModel {
        return DateIntervalPickerViewModel(dateIntervalService: DateIntervalServiceImpl(),
                                           computingService: transactionsComputingService)
    }
    
    func attach(updater: CollectionUpdater) {
        collectionUpdater = updater
        createCollectionUpdateHandler()
        createFRC()
    }
    
    func transactionsCount() -> Int {
        return transactionsFRC?.fetchedObjects?.count ?? 0
    }
    
    func transactionCellViewModel(atIndex index: Int) -> TransactionCellViewModel {
        let transaction = transactionsFRC!.fetchedObjects![index]
        return TransactionCellViewModelImplementation(transaction: transaction)
    }
    
    // MARK: Private
    
    private func createCollectionUpdateHandler() {
        guard let updater = collectionUpdater else {
            return
        }
        
        collectionUpdateHandler = CoreDataCollectionUpdateHandler(collectionUpdater: updater)
    }
    
    private func createFRC() {
        transactionsService.getRepository().allDataFRC { [weak self] (frc) in
            self?.transactionsFRC = frc
            self?.transactionsFRC?.delegate = self?.collectionUpdateHandler
            do {
                try self?.transactionsFRC?.performFetch()
                self?.collectionUpdater?.reloadAll()
            } catch {
                self?.logger.log(withLevel: .error, message: error.localizedDescription)
            }
            
        }
    }
}
