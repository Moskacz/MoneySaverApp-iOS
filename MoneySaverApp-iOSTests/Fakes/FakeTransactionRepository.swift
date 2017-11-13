//
//  FakeTransactionRepository.swift
//  MoneySaverApp-iOSTests
//
//  Created by Michal Moskala on 23.10.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation
import CoreData
@testable import MoneySaverApp_iOS

class FakeTransactionsRepository: TransactionsRepository {
    func allDataFRC() -> NSFetchedResultsController<TransactionManagedObject> {
        return NSFetchedResultsController()
    }
    func addTransaction(data: TransactionData, category: TransactionCategoryManagedObject) {}
    func remove(transaction: TransactionManagedObject) {}
}
