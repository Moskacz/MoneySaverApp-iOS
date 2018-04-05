//
//  DateRangePickerViewModelTests.swift
//  MoneySaverApp-iOSTests
//
//  Created by Michal Moskala on 04.04.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import XCTest
@testable import MoneySaverApp_iOS

class DateRangePickerViewModelTests: XCTestCase {
    
    var calendarFake: FakeCalendar!
    var sut: DateRangePickerViewModel!
    
    override func setUp() {
        super.setUp()
        calendarFake = FakeCalendar()
        sut = DateRangePickerViewModel(calendar: calendarFake)
        fakeDates()
    }
    
    override func tearDown() {
        sut = nil
        calendarFake = nil
        super.tearDown()
    }
    
    private func fakeDates() {
        calendarFake.nowToReturn = Date()
        calendarFake.monthNameToReturn = "April"
        calendarFake.yearNameToReturn = "2018"
    }
    
    func test_rangesContainToday() {
        let today = sut.ranges.first { $0.range == .today }
        XCTAssertNotNil(today)
        XCTAssertEqual(today?.title, "Today")
    }
    
    func test_rangesContainAllTime() {
        let allTime = sut.ranges.first { $0.range == .allTime }
        XCTAssertNotNil(allTime)
        XCTAssertEqual(allTime?.title, "All")
    }
    
    func test_rangesContainThisMonth_withCurrentMonthName() {
        let thisMonth = sut.ranges.first { $0.range == .thisMonth }
        XCTAssertNotNil(thisMonth)
        XCTAssertEqual(thisMonth?.title, "Month - April")
    }
    
    func test_rangesContainsThisYear_withCurrentYearName() {
        let thisYear = sut.ranges.first { $0.range == .thisYear }
        XCTAssertNotNil(thisYear)
        XCTAssertEqual(thisYear?.title, "Year - 2018")
    }
}
