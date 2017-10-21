//
//  TransactionsListViewModel.swift
//  MoneySaverApp-iOS
//
//  Created by Michał Moskała on 27.03.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation
import RxSwift
import MoneySaverFoundationiOS
import CoreData

class TransactionsListViewModel {
    
    private let transactionsModel: TransactionsModel
    private let transactionsComputingModel: TransactionsComputingModel
    private let logger: Logger
    private let disposeBag = DisposeBag()
    
    private var collectionUpdater: CollectionUpdater?
    private var transactionsFRC: NSFetchedResultsController<TransactionManagedObject>?
    private var collectionUpdateHandler: CoreDataCollectionUpdateHandler?
    
    init(transactionsModel: TransactionsModel,
         transactionsComputingModel: TransactionsComputingModel,
         logger: Logger) {
        self.transactionsModel = transactionsModel
        self.transactionsComputingModel = transactionsComputingModel
        self.logger = logger
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
        transactionsModel.getRepository().allDataFRC { [weak self] (frc) in
            self?.transactionsFRC? = frc
            self?.transactionsFRC?.delegate = self?.collectionUpdateHandler
            do {
                try self?.transactionsFRC?.performFetch()
                self?.collectionUpdater?.reloadAll()
            } catch {
                self?.logger.log(withLevel: .error, message: error.localizedDescription)
            }
            
        }
    }
    
    func transactionsSum() -> Observable<String?> {
        return Observable.just(nil)
    }
}
