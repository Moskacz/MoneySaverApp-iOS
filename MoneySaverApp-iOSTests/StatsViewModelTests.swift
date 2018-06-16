//
//  StatsViewModelTests.swift
//  MoneySaverApp-iOSTests
//
//  Created by Michal Moskala on 20.01.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import XCTest
import MoneySaverAppCore
@testable import MoneySaverApp_iOS

class StatsViewModelTests: XCTestCase {
    
    var repositoryFake: FakeTransactionsRepository!
    var userPreferences: FakeUserPreferences!
    var sut: StatsViewModel!
    
    override func setUp() {
        super.setUp()
        repositoryFake = FakeTransactionsRepository()
        userPreferences = FakeUserPreferences()
        userPreferences.statsGrouping = .monthOfEra
        sut = StatsViewModel(repository: repositoryFake,
                             dataProcessor: FakeChartsDataProcessor(),
                             userPreferences: userPreferences)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_availableGroupings() {
        XCTAssertEqual(sut.availableGroupings, [TransactionsGrouping.dayOfEra,
                                                TransactionsGrouping.weekOfEra,
                                                TransactionsGrouping.monthOfEra])
    }
    
    func test_afterInitSelectedGroupingIndex_shouldBeCorrectlySet() {
        userPreferences.statsGrouping = .dayOfEra
        sut = StatsViewModel(repository: repositoryFake,
                             dataProcessor: FakeChartsDataProcessor(),
                             userPreferences: userPreferences)
        XCTAssertEqual(sut.selectedSegmentIndex, 0)
    }
    
    func test_whenSelectedSegmentIndexIsChanged_thenCorrespondingGroupingShouldBeSavedAsPreferredOne() {
        sut.selectedSegmentIndex = 1
        XCTAssertEqual(userPreferences.statsGrouping, .weekOfEra)
    }
}
