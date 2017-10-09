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
}

class TransactionsModelImplementation: TransactionsModel {
    
    private let serverInterface: TransactionsServerInterface
    private let repository: TransactionsRepository
    private let logger: Logger
    
    init(serverInterface: TransactionsServerInterface,
         repository: TransactionsRepository,
         logger: Logger) {
        self.serverInterface = serverInterface
        self.repository = repository
        self.logger = logger
    }
    
    func getRepository() -> TransactionsRepository {
        return repository
    }

    
}
