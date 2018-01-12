//
//  ChartsDataProcessorTests.swift
//  MoneySaverApp-iOSTests
//
//  Created by Michal Moskala on 12.01.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import XCTest
@testable import MoneySaverApp_iOS

class ChartsDataProcessorTests: XCTestCase {
    
    var sut: ChartsDataProcessorImpl!
    
    override func setUp() {
        super.setUp()
        sut = ChartsDataProcessorImpl()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_spendingFromMonthlyExpenses_shouldSortPassedData() {
        let firstDayExpense = DailyValue(day: 0, value: Decimal(floatLiteral: 50))
        let secondDayExpense = DailyValue(day: 1, value: Decimal(floatLiteral: 10))
        let spendings = sut.spendings(fromMonthlyExpenses: [secondDayExpense, firstDayExpense])
        XCTAssertEqual(spendings[0].value, -50)
    }
    
    func test_monthlySpendings_dailyExpensesShouldBeSumOfEarlierDays() {
        let firstDayExpense = DailyValue(day: 0, value: Decimal(floatLiteral: 50))
        let secondDayExpense = DailyValue(day: 1, value: Decimal(floatLiteral: 10))
        let spendings = sut.spendings(fromMonthlyExpenses: [firstDayExpense, secondDayExpense])
        XCTAssertEqual(spendings[1].value, -60)
    }
    
}
