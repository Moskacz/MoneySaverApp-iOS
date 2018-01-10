//
//  StringTests.swift
//  MoneySaverApp-iOSTests
//
//  Created by Michal Moskala on 10.01.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import XCTest
@testable import MoneySaverApp_iOS

class StringTests: XCTestCase {
    
    func test_firstUppercased() {
        XCTAssertEqual("".firstUppercased, "")
        XCTAssertEqual("aa".firstUppercased, "Aa")
        XCTAssertEqual("AAA".firstUppercased, "Aaa")
    }
    
}
