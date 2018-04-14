//
//  CalendarDateManagedObjectTests.swift
//  MoneySaverApp-iOSTests
//
//  Created by Michal Moskala on 14.04.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import XCTest
import CoreData
@testable import MoneySaverApp_iOS

class CalendarDateManagedObjectTests: XCTestCase {
    
    func test_updateProperties() {
        let date = CalendarDate(calendarIdentifier: "test",
                                dayOfEra: 1,
                                dayOfMonth: 2,
                                dayOfYear: 3,
                                era: 4,
                                weekOfEra: 5,
                                weekOfMonth: 6,
                                weekOfYear: 7,
                                year: 8,
                                timeInterval: 9,
                                monthOfYear: 10,
                                monthOfEra: 11)
        
        let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        let managedObject = CalendarDateManagedObject(context: context)
        managedObject.update(with: date)
        
        XCTAssertEqual(managedObject.calendarIdentifier, "test")
        XCTAssertEqual(managedObject.dayOfMonth, 2)
        XCTAssertEqual(managedObject.dayOfYear, 3)
        XCTAssertEqual(managedObject.era, 4)
        XCTAssertEqual(managedObject.weekOfEra, 5)
        XCTAssertEqual(managedObject.weekOfMonth, 6)
        XCTAssertEqual(managedObject.weekOfYear, 7)
        XCTAssertEqual(managedObject.year, 8)
        XCTAssertEqual(managedObject.timeInterval, 9)
        XCTAssertEqual(managedObject.monthOfYear, 10)
        XCTAssertEqual(managedObject.monthOfEra, 11)
    }
}
