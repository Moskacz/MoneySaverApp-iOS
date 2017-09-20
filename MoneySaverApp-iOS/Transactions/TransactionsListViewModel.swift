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

class TransactionsListViewModel{
    
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
    
    func refreshData() {
        transactionsModel.refreshData().subscribe().addDisposableTo(disposeBag)
    }
    
    func transactionsCount() -> Int {
        return 0
    }
    
    func transactionCellViewModel(atIndex index: Int) -> TransactionCellViewModel {
        fatalError()
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
            collectionUpdater?.reloadAll()
        } catch {
            logger.log(withLevel: .error, message: error.localizedDescription)
        }
    }
    
    func transactionsSum() -> Observable<String?> {
        return transactionsComputingModel.sumOfAllTransactionsObservable().map({ (sum: NSDecimalNumber) -> String in
            return "\(sum)"
        }).observeOn(MainScheduler.instance)
    }
}
