//
//  BudgetViewModelTests.swift
//  MoneySaverApp-iOSTests
//
//  Created by Michal Moskala on 19.05.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import XCTest
@testable import MoneySaverApp_iOS
import MoneySaverAppCore

class BudgetViewModelTests: XCTestCase {
    
    var sut: BudgetViewModel!
    var repository: FakeBudgetRepository!
    var computingService: FakeTransactionsComputingService!
    var dataProcessor: FakeChartsDataProcessor!
    
    override func setUp() {
        super.setUp()
        repository = FakeBudgetRepository()
        computingService = FakeTransactionsComputingService()
        dataProcessor = FakeChartsDataProcessor()
        sut = BudgetViewModel(computingService: computingService,
                              dataProcessor: dataProcessor,
                              budgetRepository: repository)
    }
    
    override func tearDown() {
        sut = nil
        repository = nil
        computingService = nil
        dataProcessor = nil
        super.tearDown()
    }

}
