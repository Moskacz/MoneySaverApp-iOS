//
//  TransactionsRepositoryTests.swift
//  MoneySaverApp-iOSTests
//
//  Created by Michal Moskala on 14.01.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import XCTest
import CoreData
@testable import MoneySaverApp_iOS

class TransactionsRepositoryTests: XCTestCase {
    
    var context: NSManagedObjectContext!
    var fakeCaledar: FakeCalendar!
    var sut: TransactionsRepositoryImplementation!
    
    override func setUp() {
        super.setUp()
        context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        fakeCaledar = FakeCalendar()
        sut = TransactionsRepositoryImplementation(context: context,
                                                   logger: NullLogger(),
                                                   calendar: fakeCaledar)
    }
    
    override func tearDown() {
        sut = nil
        context = nil
        fakeCaledar = nil
        super.tearDown()
    }
    
    func test_predicateForDateRange_ifRangeIsAllTime_thenShouldReturnNil() {
        fakeCaledar.nowToReturn = Date()
        let predicate = sut.predicate(forDateRange: .allTime)
        XCTAssertNil(predicate)
    }
    
    func test_predicateForDateRange_todayRange() {
        fakeCaledar.nowToReturn = Date()
        fakeCaledar.dayOfEraOfDateToReturn = 5
        
        let predicate = sut.predicate(forDateRange: .today)
        XCTAssertEqual(predicate?.predicateFormat, "date.dayOfEra == 5")
    }
    
    func test_predicateForDateRange_thisWeekRange() {
        fakeCaledar.nowToReturn = Date()
        fakeCaledar.weekOfEraOfDateToReturn = 5
        
        let predicate = sut.predicate(forDateRange: .thisWeek)
        XCTAssertEqual(predicate?.predicateFormat, "date.weekOfEra == 5")
    }
    
    func test_predicateForDateRange_thisMonth() {
        fakeCaledar.nowToReturn = Date()
        fakeCaledar.monthOfEraOfDateToReturn = 5
        
        let predicate = sut.predicate(forDateRange: .thisMonth)
        XCTAssertEqual(predicate?.predicateFormat, "date.monthOfEra == 5")
    }
    
    func test_predicateForDateRange_thisYear() {
        fakeCaledar.nowToReturn = Date()
        fakeCaledar.yearOfDateToReturn = 2018
        
        let predicate = sut.predicate(forDateRange: .thisYear)
        XCTAssertEqual(predicate?.predicateFormat, "date.year == 2018")
    }
    
    
}
