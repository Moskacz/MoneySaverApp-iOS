//
//  TransactionsRepositoryTests.swift
//  MoneySaverApp-iOSTests
//
//  Created by Michal Moskala on 14.01.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import XCTest
import CoreData
import MoneySaverAppCore
@testable import MoneySaverApp_iOS

class TransactionsRepositoryTests: XCTestCase {

    var coreDataStack: InMemoryCoreDataStack!
    var fakeCaledar: FakeCalendar!
    var sut: TransactionsRepositoryImplementation!
    
    override func setUp() {
        super.setUp()
        coreDataStack = InMemoryCoreDataStack()
        fakeCaledar = FakeCalendar()
        sut = TransactionsRepositoryImplementation(context: coreDataStack.getViewContext(),
                                                   logger: NullLogger(),
                                                   calendar: fakeCaledar)
    }
    
    override func tearDown() {
        sut = nil
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
    
    func test_groupedTransactions_dayGrouping() {
        // commented out for now, it cannot be tested with in memory core data store
        
//        let context = coreDataStack.getViewContext()
//
//        let day1Transaction1 = TransactionManagedObject.createEntity(inContext: context)
//        day1Transaction1.value = NSDecimalNumber(value: 20)
//        day1Transaction1.date = calendarDate(dayOfEra: 1)
//
//        let day1Transaction2 = TransactionManagedObject.createEntity(inContext: context)
//        day1Transaction2.value = NSDecimalNumber(value: 10)
//        day1Transaction2.date = calendarDate(dayOfEra: 1)
//
//        let day2Transaction = TransactionManagedObject.createEntity(inContext: context)
//        day2Transaction.value = NSDecimalNumber(value: 123)
//        day2Transaction.date = calendarDate(dayOfEra: 2)
//
//        let grouped = try! sut.groupedTransactions(grouping: .day)
//        XCTAssertEqual(grouped[0], DatedValue(date: 1, value: 30)) // 20 + 10
//        XCTAssertEqual(grouped[1], DatedValue(date: 2, value: 123))
    }
    
    // MARK: Helpers
    
    private func calendarDate(dayOfEra: Int32 = 0, weekOfEra: Int32 = 0, monthOfEra: Int32 = 0) -> CalendarDateManagedObject {
        let context = coreDataStack.getViewContext()
        let date = CalendarDateManagedObject.createEntity(inContext: context)
        date.dayOfEra = dayOfEra
        date.weekOfEra = weekOfEra
        date.monthOfEra = monthOfEra
        return date
    }
    
}
