//
//  DateIntervalServiceTests.swift
//  MoneySaverApp-iOSTests
//
//  Created by Michal Moskala on 04.11.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import XCTest
@testable import MoneySaverApp_iOS

class DateIntervalServiceTests: XCTestCase {
    
    var sut: CalendarServiceImpl!
    
    override func setUp() {
        super.setUp()
        let dateProvider = FakeCurrentDateProvider()
        // 11.04.2017 10:00:00 GMT
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: "GMT")!
        dateProvider.date = Date(timeIntervalSince1970: 1509789600)
        sut = CalendarServiceImpl(calendar: calendar, dateProvider: dateProvider)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_calculateTodayDateInterval() {
        let dateInterval = sut.dateInterval(forType: .today)!
        // 11.04.2017 00:00:00 GMT
        let startDate = Date(timeIntervalSince1970: 1509753600)
        // 12.04.2017 00:00:00 GMT
        let endDate = Date(timeIntervalSince1970: 1509840000)
        XCTAssertEqual(dateInterval.start, startDate)
        XCTAssertEqual(dateInterval.end, endDate)
    }
    
    func test_calculateThisWeekDateInterval() {
        let dateInterval = sut.dateInterval(forType: .currentWeek)!
        // 29.10.2017 00:00:00 GMT
        let startDate = Date(timeIntervalSince1970: 1509235200)
        // 5.12.2017 00:00:00 GMT
        let endDate = Date(timeIntervalSince1970: 1509840000)
        XCTAssertEqual(dateInterval.start, startDate)
        XCTAssertEqual(dateInterval.end, endDate)
    }
    
    func test_calculateThisMonthDateInterval() {
        let dateInterval = sut.dateInterval(forType: .currentMonth)!
        // 1.11.2017 00:00:00 GMT
        let startDate = Date(timeIntervalSince1970: 1509494400)
        // 1.12.2017 00:00:00 GMT
        let endDate = Date(timeIntervalSince1970: 1512086400)
        XCTAssertEqual(dateInterval.start, startDate)
        XCTAssertEqual(dateInterval.end, endDate)
    }
    
    func test_calculateThisYearDateInterval() {
        let dateInterval = sut.dateInterval(forType: .currentYear)!
        // 01.01.2017 00:00:00 GMT
        let startDate = Date(timeIntervalSince1970: 1483228800)
        // 01.01.2018 00:00:00 GMT
        let endDate = Date(timeIntervalSince1970: 1514764800)
        XCTAssertEqual(dateInterval.start, startDate)
        XCTAssertEqual(dateInterval.end, endDate)
    }
    
}
