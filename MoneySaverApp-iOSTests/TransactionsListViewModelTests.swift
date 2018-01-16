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
    var appPreservtionModel: FakeAppPreservationModel!
    var sut: TransactionsListViewModel!
    
    override func setUp() {
        super.setUp()
        repositoryFake = FakeTransactionsRepository()
        transactionsFRCFake = FakeTransactionsResultsController()
        repositoryFake.allTransactionFRCToReturn = transactionsFRCFake
        calendarFake = FakeCalendar()
        computingServiceFake = FakeTransactionsComputingService()
        timeChangedObserver = FakeTimeChangedObserver()
        appPreservtionModel = FakeAppPreservationModel()
        sut = TransactionsListViewModel(repository: repositoryFake,
                                        transactionsComputingService: computingServiceFake,
                                        logger: NullLogger(),
                                        calendar: calendarFake,
                                        timeChangedObserver: timeChangedObserver,
                                        appPreservationModel: appPreservtionModel)
    }
    
    override func tearDown() {
        sut = nil
        repositoryFake = nil
        calendarFake = nil
        computingServiceFake = nil
        timeChangedObserver = nil
        super.tearDown()
    }
    
    func test_whenTimeChanged_thenListShouldBeReloaded() {
        let updater = FakeCollectionUpdater()
        sut.attach(updater: updater)
        updater.reloadAllCalled = false
        timeChangedObserver.delegate?.timeChanged()
        XCTAssertTrue(updater.reloadAllCalled)
    }
    
    func test_whenDateRangeChanged_thenListShouldBeReloaded() {
        let updater = FakeCollectionUpdater()
        sut.attach(updater: updater)
        updater.reloadAllCalled = false
        sut.summary(view: TransactionsSummaryView(), didSelectElementWith: DateRange.thisMonth)
        XCTAssertTrue(updater.reloadAllCalled)
    }
    
    func test_whenUpdaterAttached_thenFRCShouldFetchData() {
        sut.attach(updater: FakeCollectionUpdater())
        XCTAssertTrue(transactionsFRCFake.performFetchCalled)
    }
    
    func test_whenDateRangeChanged_thenFRCShouldFetchData() {
        sut.attach(updater: FakeCollectionUpdater())
        transactionsFRCFake.performFetchCalled = false
        sut.summary(view: TransactionsSummaryView(), didSelectElementWith: DateRange.thisMonth)
        XCTAssertTrue(transactionsFRCFake.performFetchCalled)
    }
    
    func test_whenDateRangeChanged_thenNewFilterShouldBeSaved() {
        sut.summary(view: TransactionsSummaryView(), didSelectElementWith: DateRange.thisWeek)
        XCTAssertTrue(appPreservtionModel.saveFilerCalled)
    }
    
    func test_whenThereIsSavedDateRangeFilter_thenItIsAvailable() {
        appPreservtionModel.savedFilterToReturn = DateRange.thisYear
        XCTAssertEqual(sut.dateRangeFilter, DateRange.thisYear)
    }
    
    func test_whenThereIsNoSavedDateRangeFilter_thenInitialValueShouldEqualToAllTime() {
        XCTAssertEqual(sut.dateRangeFilter, DateRange.allTime)
    }
}
