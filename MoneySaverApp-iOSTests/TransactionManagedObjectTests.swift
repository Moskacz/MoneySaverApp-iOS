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
    
    func test_predicateForDateRange_ifRangeIsAllTime_thenShouldReturnNil() {
        let predicate = TransactionManagedObject.predicate(forDateRange: .allTime, value: 0)
        XCTAssertNil(predicate)
    }
    
    func test_predicateForDateRange_todayRange() {
        let predicate = TransactionManagedObject.predicate(forDateRange: .today, value: 5)
        XCTAssertEqual(predicate?.predicateFormat, "dayOfEra == 5")
    }
    
    func test_predicateForDateRange_thisWeekRange() {
        let predicate = TransactionManagedObject.predicate(forDateRange: .thisWeek, value: 5)
        XCTAssertEqual(predicate?.predicateFormat, "weekOfEra == 5")
    }
    
    func test_predicateForDateRange_thisMonth() {
        let predicate = TransactionManagedObject.predicate(forDateRange: .thisMonth, value: 5)
        XCTAssertEqual(predicate?.predicateFormat, "monthOfEra == 5")
    }
    
    func test_predicateForDateRange_thisYear() {
        let predicate = TransactionManagedObject.predicate(forDateRange: .thisYear, value: 2018)
        XCTAssertEqual(predicate?.predicateFormat, "year == 2018")
    }
    
}
