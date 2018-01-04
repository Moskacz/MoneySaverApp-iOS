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
    var context: NSManagedObjectContext {
        fatalError()
    }
    
    var fetchRequest: NSFetchRequest<TransactionManagedObject> {
        fatalError()
    }
    
    var expensesOnlyPredicate: NSPredicate {
        fatalError()
    }
    
    var currentYearOnlyPredicate: NSPredicate {
        fatalError()
    }
    
    func predicate(forDateComponent component: TransactionDateComponent) -> NSPredicate {
        fatalError()
    }
    
    func addTransaction(data: TransactionData, category: TransactionCategoryManagedObject) {
        fatalError()
    }
    
    func remove(transaction: TransactionManagedObject) {
        fatalError()
    }
    
    
}
