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
    
    func predicate(forDateRange range: DateRange) -> NSPredicate? {
        return nil
    }
    
    func addTransaction(data: TransactionData, category: TransactionCategoryManagedObject) {
        
    }
    
    func remove(transaction: TransactionManagedObject) {
        
    }
    
    
}
