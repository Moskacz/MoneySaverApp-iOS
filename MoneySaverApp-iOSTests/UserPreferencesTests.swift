//
//  UserPreferencesTests.swift
//  MoneySaverApp-iOSTests
//
//  Created by Michal Moskala on 08.04.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import XCTest
@testable import MoneySaverApp_iOS

class UserPreferencesTests: XCTestCase {
    
    func test_whenUserSavesDateRange_itShouldBeStored() {
        let userDef = UserDefaults()
        userDef.dateRange = DateRange.thisMonth
        XCTAssertEqual(userDef.dateRange, DateRange.thisMonth)
    }
    
    func test_whenThereIsNoSavedDateRange_thenAllTimeShouldBeReturned() {
        let userDef = UserDefaults()
        XCTAssertEqual(userDef.dateRange, DateRange.allTime)
    }
    
}
