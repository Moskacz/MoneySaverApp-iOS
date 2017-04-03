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
    
    init(transactionsModel: TransactionsModel) {
        self.transactionsModel = transactionsModel
    }
    
    func fetchData() -> Observable<Void> {
        return transactionsModel.getTransactions().do(onNext: { [weak self] (transactions: [Transaction]) in
            self?.transactions = transactions
        }).mapToVoid().observeOn(MainScheduler.instance)
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
