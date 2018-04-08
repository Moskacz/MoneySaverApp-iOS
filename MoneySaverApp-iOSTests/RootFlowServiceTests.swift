//
//  RootFlowServiceTests.swift
//  MoneySaverApp-iOSTests
//
//  Created by Michal Moskala on 15.01.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import XCTest
@testable import MoneySaverApp_iOS

class RootFlowServiceTests: XCTestCase {
    
    var repositoryFake: FakeTransactionsRepository!
    var userPreferencesFake: FakeUserPreferences!
    var sut: RootFlowServiceImpl!
    
    override func setUp() {
        super.setUp()
        repositoryFake = FakeTransactionsRepository()
        userPreferencesFake = FakeUserPreferences()
        sut = RootFlowServiceImpl(repository: repositoryFake,
                                  userPreferences: userPreferencesFake)
    }
    
    override func tearDown() {
        sut = nil
        repositoryFake = nil
        super.tearDown()
    }
    
    func test_addTransaction_shouldCallRepository() {
        let data = TransactionData(title: "", value: Decimal(0), creationDate: Date())
        let category = TransactionCategoryManagedObject()
        sut.addTransaction(withData: data, category: category)
        XCTAssertTrue(repositoryFake.addTransactionCalled)
    }
    
    func test_setDateRange_shouldSetOnUserPreferences() {
        let value = DateRange.thisWeek
        sut.preferredDateRange = value
        XCTAssertEqual(userPreferencesFake.dateRangeStub, value)
    }
    
    func test_getDateRange_shouldGetFromUserPreferences() {
        let value = DateRange.today
        userPreferencesFake.dateRangeStub = value
        XCTAssertEqual(sut.preferredDateRange, value)
    }
}
