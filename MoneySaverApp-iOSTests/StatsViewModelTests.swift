//
//  StatsViewModelTests.swift
//  MoneySaverApp-iOSTests
//
//  Created by Michal Moskala on 20.01.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import XCTest
@testable import MoneySaverApp_iOS

class StatsViewModelTests: XCTestCase {
    
    var repositoryFake: FakeTransactionsRepository!
    var sut: StatsViewModel!
    
    override func setUp() {
        super.setUp()
        repositoryFake = FakeTransactionsRepository()
        sut = StatsViewModel(repository: repositoryFake)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_availableGroupings() {
        XCTAssertEqual(sut.availableGroupings, [TransactionsGrouping.day, TransactionsGrouping.week, TransactionsGrouping.month])
    }
    
    func test_selectedGrouping() {
        XCTAssertEqual(sut.selectedGrouping, 2)
    }
}
