//
//  CalendarTests.swift
//  MoneySaverApp-iOSTests
//
//  Created by Michal Moskala on 09.01.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import XCTest
@testable import MoneySaverApp_iOS

class CalendarTests: XCTestCase {
    
    var calendar: CalendarProtocol!
    
    override func setUp() {
        super.setUp()
        calendar = Calendar.current
    }
    
    override func tearDown() {
        calendar = nil
        super.tearDown()
    }
    
    func test_structuredDate() {
        let sut = calendar.structuredDate(forDate: testedDate)
        XCTAssertEqual(sut.dayOfWeek, 3)
        XCTAssertEqual(sut.dayOfMonth, 9)
        XCTAssertEqual(sut.dayOfYear, 9)
        XCTAssertEqual(sut.weekOfYear, 2)
        XCTAssertEqual(sut.dayOfEra, 736703)
        XCTAssertEqual(sut.year, 2018)
        XCTAssertEqual(sut.era, 1)
    }
    
    func test_monthName() {
        XCTAssertEqual(calendar.monthName(forDate: testedDate), "Styczeń")
    }
    
    func test_yearName() {
        XCTAssertEqual(calendar.yearName(forDate: testedDate), "2018")
    }
    
    func test_numerOfDaysInMonth() {
        let range = calendar.daysInMonthRange(forDate: testedDate)
        XCTAssertEqual(range.count, 31)
    }
    
    private var testedDate: Date {
        // 09/01/2018 @ 1:33pm (UTC)
        return Date(timeIntervalSince1970: 1515504813)
    }
    
}
