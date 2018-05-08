//
//  FakeFetchedResultsController.swift
//  MoneySaverApp-iOSTests
//
//  Created by Michal Moskala on 15.01.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import Foundation
import CoreData
import MoneySaverAppCore

class FakeTransactionsResultsController: NSFetchedResultsController<TransactionManagedObject> {
    
    var performFetchCalled = false
    
    func reset() {
        performFetchCalled = false
    }
    
    override var sections: [NSFetchedResultsSectionInfo]? { return nil }
    
    override func performFetch() throws {
        performFetchCalled = true
    }
}

protocol FetchedResultsController {
    var sections: [NSFetchedResultsSectionInfo]? { get }
    func performFetch() throws
}

extension NSFetchedResultsController: FetchedResultsController {}
