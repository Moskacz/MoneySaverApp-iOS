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
    func getTransactions() -> Observable<[Transaction]>
    func addTransaction(withParameters parameters: [AnyHashable: Any]) -> Observable<Transaction>
}

class TransactionsModelImplementation: TransactionsModel {
    
    let restClient: TransactionsRESTClient
    
    init(restClient: TransactionsRESTClient) {
        self.restClient = restClient
    }
    
    func getTransactions() -> Observable<[Transaction]> {
        return restClient.getTransactions()
    }
    
    func addTransaction(withParameters parameters: [AnyHashable: Any]) -> Observable<Transaction> {
        return restClient.postTransaction(withParameters: parameters)
    }
}
