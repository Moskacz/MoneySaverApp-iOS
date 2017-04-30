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
    private var transactions: [TransactionManagedObject]?
    private let disposeBag = DisposeBag()
    
    private var collectionUpdater: CollectionUpdater?
    private var transactionsFRC: NSFetchedResultsController<TransactionManagedObject>?
    private var collectionUpdateHandler: CoreDataCollectionUpdateHandler?
    
    init(transactionsModel: TransactionsModel) {
        self.transactionsModel = transactionsModel
    }
    
    func attach(updater: CollectionUpdater) {
        collectionUpdater = updater
        createFRC()
    }
    
    func refreshData() {
        transactionsModel.refreshData().subscribe().addDisposableTo(disposeBag)
    }
    
    func transactionsCount() -> Int {
        guard let data = transactions else {
            return 0
        }
        
        return data.count
    }
    
    func transactionCellViewModel(atIndex index: Int) -> TransactionCellViewModel {
        let transaction = transactions![index]
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
        transactionsFRC = transactionsModel.getRepository().allDataFRC()
        transactionsFRC?.delegate = collectionUpdateHandler
        
        do {
            try transactionsFRC?.performFetch()
            transactions = transactionsFRC?.fetchedObjects
        } catch {
            print(error)
        }
    }
}
