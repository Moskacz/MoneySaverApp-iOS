//
//  FakeTransactionsService.swift
//  MoneySaverApp-iOSTests
//
//  Created by Michal Moskala on 23.10.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation
@testable import MoneySaverApp_iOS

class FakeTransactionsService: TransactionsService {
    func getRepository() -> TransactionsRepository {
        return FakeTransactionsRepository()
    }
    func addTransaction(data: TransactionData, category: TransactionCategoryManagedObject) {}
}
