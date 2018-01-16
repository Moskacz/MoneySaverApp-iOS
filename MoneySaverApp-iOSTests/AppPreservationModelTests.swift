//
//  AppPreservationModelTests.swift
//  MoneySaverApp-iOSTests
//
//  Created by Michal Moskala on 16.01.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import XCTest
@testable import MoneySaverApp_iOS

class AppPreservationModelTests: XCTestCase {
   
    var storageFake: FakeUserDefaults!
    var sut: AppPreservationModel!
    
    override func setUp() {
        super.setUp()
        storageFake = FakeUserDefaults()
        sut = AppPreservationModelImpl(storage: storageFake)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_whenThereIsSavedFilter_thenInShouldBeReturned() {
        let filter = DateRange.thisMonth
        storageFake.valueForKeyToReturn = filter.rawValue
        XCTAssertEqual(sut.savedDateRangeFilter, filter)
    }
    
    func test_whenThereIsNoSavedFilter_thenInShouldReturnNil() {
        XCTAssertNil(sut.savedDateRangeFilter)
    }
    
    func test_whenSaveIsCalled_thenIsShouldBeStored() {
        let filter = DateRange.thisWeek
        sut.save(dateRangeFilter: filter)
        XCTAssertEqual(storageFake.valuePassed as! String, filter.rawValue)
    }
    
}
