//
//  TransactionsListViewModelTests.swift
//  MoneySaverApp-iOSTests
//
//  Created by Michal Moskala on 15.01.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import XCTest
@testable import MoneySaverApp_iOS

class TransactionsListViewModelTests: XCTestCase {
    
    var repositoryFake: FakeTransactionsRepository!
    var transactionsFRCFake: FakeTransactionsResultsController!
    var calendarFake: FakeCalendar!
    var computingServiceFake: FakeTransactionsComputingService!
    var timeChangedObserver: FakeTimeChangedObserver!
    var sut: TransactionsListViewModel!
    
    override func setUp() {
        super.setUp()
        repositoryFake = FakeTransactionsRepository()
        transactionsFRCFake = FakeTransactionsResultsController()
        repositoryFake.allTransactionFRCToReturn = transactionsFRCFake
        calendarFake = FakeCalendar()
        computingServiceFake = FakeTransactionsComputingService()
        timeChangedObserver = FakeTimeChangedObserver()
        sut = TransactionsListViewModel(repository: repositoryFake,
                                        logger: NullLogger(),
                                        calendar: calendarFake,
                                        timeChangedObserver: timeChangedObserver,
                                        dateRange: .allTime)
    }
    
    override func tearDown() {
        sut = nil
        repositoryFake = nil
        calendarFake = nil
        computingServiceFake = nil
        timeChangedObserver = nil
        super.tearDown()
    }
    
    func test_whenTimeChanged_thenFRCShouldFetchData() {
        sut.attach(updater: FakeCollectionUpdater())
        transactionsFRCFake.reset()
        timeChangedObserver.delegate?.timeChanged()
        XCTAssertTrue(transactionsFRCFake.performFetchCalled)
    }

    
    func test_whenUpdaterAttached_thenFRCShouldFetchData() {
        sut.attach(updater: FakeCollectionUpdater())
        XCTAssertTrue(transactionsFRCFake.performFetchCalled)
    }
    
}
