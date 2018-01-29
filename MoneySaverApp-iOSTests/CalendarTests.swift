//
//  CalendarTests.swift
//  MoneySaverApp-iOSTests
//
//  Created by Michal Moskala on 09.01.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import XCTest
import CoreData
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
    
    func test_dayOfEra() {
        XCTAssertEqual(calendar.dayOfEraOf(date: testedDate), 736703)
    }
    
    func test_weekOfEra() {
        XCTAssertEqual(calendar.weekOfEraOf(date: testedDate), 105244)
    }
    
    func test_monthOfEra() {
        XCTAssertEqual(calendar.monthOfEraOf(date: testedDate), 24205)
    }
    
    func test_year() {
        XCTAssertEqual(calendar.yearOf(date: testedDate), 2018)
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
    
    func test_calendarStringIdentifier() {
        XCTAssertEqual(Calendar.Identifier.buddhist.stringIdentifier, "buddhist")
        XCTAssertEqual(Calendar.Identifier.chinese.stringIdentifier, "chinese")
        XCTAssertEqual(Calendar.Identifier.coptic.stringIdentifier, "coptic")
        XCTAssertEqual(Calendar.Identifier.ethiopicAmeteAlem.stringIdentifier, "ethiopicAmeteAlem")
        XCTAssertEqual(Calendar.Identifier.ethiopicAmeteMihret.stringIdentifier, "ethiopicAmeteMihret")
        XCTAssertEqual(Calendar.Identifier.gregorian.stringIdentifier, "gregorian")
        XCTAssertEqual(Calendar.Identifier.hebrew.stringIdentifier, "hebrew")
        XCTAssertEqual(Calendar.Identifier.indian.stringIdentifier, "indian")
        XCTAssertEqual(Calendar.Identifier.islamic.stringIdentifier, "islamic")
        XCTAssertEqual(Calendar.Identifier.islamicCivil.stringIdentifier, "islamicCivil")
        XCTAssertEqual(Calendar.Identifier.islamicTabular.stringIdentifier, "islamicTabular")
        XCTAssertEqual(Calendar.Identifier.islamicUmmAlQura.stringIdentifier, "islamicUmmAlQura")
        XCTAssertEqual(Calendar.Identifier.iso8601.stringIdentifier, "iso8601")
        XCTAssertEqual(Calendar.Identifier.japanese.stringIdentifier, "japanese")
        XCTAssertEqual(Calendar.Identifier.persian.stringIdentifier, "persian")
        XCTAssertEqual(Calendar.Identifier.republicOfChina.stringIdentifier, "republicOfChina")
    }
    
    func test_fillCalendarDayProperty() {
        let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        let calendarDay = CalendarDay(context: context)
        calendar.fillPropertiesOf(calendarDay: calendarDay, withDate: testedDate)
        XCTAssertEqual(calendarDay.dayOfWeek, 3)
        XCTAssertEqual(calendarDay.dayOfMonth, 9)
        XCTAssertEqual(calendarDay.dayOfYear, 9)
        XCTAssertEqual(calendarDay.weekOfMonth, 2)
        XCTAssertEqual(calendarDay.weekOfYear, 2)
        XCTAssertEqual(calendarDay.year, 2018)
        XCTAssertEqual(calendarDay.era, 1)
        XCTAssertNotNil(calendarDay.calendarIdentifier)
    }
    
    private var testedDate: Date {
        // 09/01/2018 @ 1:33pm (UTC)
        return Date(timeIntervalSince1970: 1515504813)
    }
    
}
