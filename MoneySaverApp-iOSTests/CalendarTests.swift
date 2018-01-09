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
    
    func test_structuredDate() {
        let calendar = Calendar.current
        // 09/01/2018 @ 1:33pm (UTC)
        let date = Date(timeIntervalSince1970: 1515504813)
        let sut = calendar.structuredDate(forDate: date)
        XCTAssertEqual(sut.dayOfWeek, 3)
        XCTAssertEqual(sut.dayOfMonth, 9)
        XCTAssertEqual(sut.dayOfYear, 9)
        XCTAssertEqual(sut.weekOfYear, 2)
        XCTAssertEqual(sut.dayOfEra, 736703)
        XCTAssertEqual(sut.year, 2018)
        XCTAssertEqual(sut.era, 1)
        
    }
    
}
