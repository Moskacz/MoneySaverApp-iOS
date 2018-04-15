//
//  TransactionManagedObjectTests.swift
//  MoneySaverApp-iOSTests
//
//  Created by Michal Moskala on 13.01.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import XCTest
@testable import MoneySaverApp_iOS

class TransactionManagedObjectTests: XCTestCase {
    
    func test_groupByKeypath() {
        let dayKeypath = TransactionManagedObject.groupByKeypathFor(grouping: .day)
        XCTAssertEqual(dayKeypath.rawValue, "date.dayOfEra")
        
        let weekKeypath = TransactionManagedObject.groupByKeypathFor(grouping: .week)
        XCTAssertEqual(weekKeypath.rawValue, "date.weekOfEra")
        
        let monthKeypath = TransactionManagedObject.groupByKeypathFor(grouping: .month)
        XCTAssertEqual(monthKeypath.rawValue, "date.monthOfEra")
    }
    
}
