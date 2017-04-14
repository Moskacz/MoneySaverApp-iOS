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

class TransactionsListViewModel {
    
    private let transactionsModel: TransactionsModel
    private var transactions: [Transaction]?
    private let disposeBag = DisposeBag()
    private var collectionUpdater: CollectionUpdater?
    
    init(transactionsModel: TransactionsModel) {
        self.transactionsModel = transactionsModel
    }
    
    func attach(updater: CollectionUpdater) {
        collectionUpdater = updater
    }
    
    func fetchData() {
        transactionsModel.getTransactions().subscribe(onNext: { [weak self] (transactions: [Transaction]) in
            self?.transactions = transactions
            self?.collectionUpdater?.endUpdates()
        }, onError: nil, onCompleted: nil, onDisposed: nil).addDisposableTo(disposeBag)
    }
    
    func transactionsCount() -> Int {
        guard let data = transactions else {
            return 0
        }
        
        return data.count
    }
    
    func transaction(atIndex index: Int) -> Transaction {
        return transactions![index]
    }
    

}
