//
//  DateFormattersTests.swift
//  MoneySaverApp-iOSTests
//
//  Created by Michal Moskala on 05.04.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import XCTest
@testable import MoneySaverApp_iOS

class DateFormattersTests: XCTestCase {
    
    func test_formatting_shortDate() {
        let formattedString = DateFormatters.formatter(forType: .shortDate).string(from: testedDate)
        XCTAssertEqual(formattedString, "09.01.2018")
        DateFormatter().dateStyle = .short
    }
    
    private var testedDate: Date {
        // 09/01/2018 @ 1:33pm (UTC)
        return Date(timeIntervalSince1970: 1515504813)
    }
    
}
