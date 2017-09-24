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
    func addTransaction(withData data: AddTransactionFormData)
}

class TransactionsModelImplementation: TransactionsModel {
    
    private let restClient: TransactionsRESTClient
    private let repository: TransactionsRepository
    private let logger: Logger
    
    init(restClient: TransactionsRESTClient,
         repository: TransactionsRepository,
         logger: Logger) {
        self.restClient = restClient
        self.repository = repository
        self.logger = logger
    }
    
    func getRepository() -> TransactionsRepository {
        return repository
    }
    
    func refreshData() -> Observable<Void> {
        return restClient.getTransactions().do(onNext: { (transactions: [Transaction]) in
            self.repository.update(withTransactions: transactions)
        }).mapToVoid()
    }
    
    func addTransaction(withData data: AddTransactionFormData) {
        let transaction = Transaction(identifier: UUID().uuidString,
                                      title: data.title,
                                      value: data.value,
                                      category: data.category,
                                      creationTimeInterval: data.creationTimeStamp)
        repository.add(transaction: transaction)
    }
    
}
