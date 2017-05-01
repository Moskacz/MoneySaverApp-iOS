//
//  TransactionsModel.swift
//  MoneySaverApp-iOS
//
//  Created by Michał Moskała on 27.03.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation
import RxSwift
import RESTClient
import MoneySaverFoundationiOS

protocol TransactionsModel {
    func getRepository() -> TransactionsRepository
    func refreshData() -> Observable<Void>
    func addTransaction(withParameters parameters: [AnyHashable: Any]) -> Observable<Void>
}

class TransactionsModelImplementation: TransactionsModel {
    
    private let restClient: TransactionsRESTClient
    private let repository: TransactionsRepository
    
    init(restClient: TransactionsRESTClient, repository: TransactionsRepository) {
        self.restClient = restClient
        self.repository = repository
    }
    
    func getRepository() -> TransactionsRepository {
        return repository
    }
    
    func refreshData() -> Observable<Void> {
        return restClient.getTransactions().do(onNext: { (transactions: [Transaction]) in
            self.repository.update(withTransactions: transactions)
        }).mapToVoid()
    }
    
    func addTransaction(withParameters parameters: [AnyHashable: Any]) -> Observable<Void> {
        return restClient.postTransaction(withParameters: parameters).do(onNext: { (transaction: Transaction) in
            self.repository.add(transaction: transaction)
        }).mapToVoid()
    }
}
