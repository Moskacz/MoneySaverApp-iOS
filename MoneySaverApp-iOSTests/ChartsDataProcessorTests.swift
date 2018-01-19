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
    
    var fakeCalendar: FakeCalendar!
    var sut: ChartsDataProcessorImpl!
    
    
    override func setUp() {
        super.setUp()
        fakeCalendar = FakeCalendar()
        sut = ChartsDataProcessorImpl(calendar: fakeCalendar)
    }
    
    override func tearDown() {
        sut = nil
        fakeCalendar = nil
        super.tearDown()
    }
    
    func test_spendingFromMonthlyExpenses_shouldSortPassedData() {
        fakeCalendar.nowToReturn = Date()
        fakeCalendar.daysInMonthRangeToReturn = 1...30
        
        let firstDayExpense = DailyValue(day: 1, value: Decimal(floatLiteral: 50))
        let secondDayExpense = DailyValue(day: 2, value: Decimal(floatLiteral: 10))
        let spendings = sut.spendings(fromMonthlyExpenses: [secondDayExpense, firstDayExpense])
        XCTAssertEqual(spendings[0].value, -50)
    }
    
    func test_monthlySpendings_dailyExpensesShouldBeSumOfEarlierDays() {
        fakeCalendar.nowToReturn = Date()
        fakeCalendar.daysInMonthRangeToReturn = 1...30
        
        let firstDayExpense = DailyValue(day: 1, value: Decimal(floatLiteral: 50))
        let secondDayExpense = DailyValue(day: 2, value: Decimal(floatLiteral: 10))
        let spendings = sut.spendings(fromMonthlyExpenses: [firstDayExpense, secondDayExpense])
        XCTAssertEqual(spendings[1].value, -60)
    }
    
    func test_monthlySpendings_spendingsCountShouldEqualDaysOfMonth() {
        let daysCount = 28
        fakeCalendar.nowToReturn = Date()
        fakeCalendar.daysInMonthRangeToReturn = 1...daysCount
        
        let spendings = sut.spendings(fromMonthlyExpenses: [])
        XCTAssertEqual(spendings.count, daysCount)
    }
    
    func test_estimatedSpending_spendingCountShouldEqualDaysOfMonth() {
        let daysCount = 28
        fakeCalendar.nowToReturn = Date()
        fakeCalendar.daysInMonthRangeToReturn = 1...daysCount
        
        let spendings = sut.estimatedSpendings(budgetValue: 0)
        XCTAssertEqual(spendings.count, daysCount)
    }
    
    func test_estimatedSpending_lastDaySpendingShouldEqualToBudgetValue() {
        fakeCalendar.nowToReturn = Date()
        fakeCalendar.daysInMonthRangeToReturn = 1...10
        let budgetValue = Double(5000)
        let lastDaySpending = sut.estimatedSpendings(budgetValue: budgetValue).last!.value
        XCTAssertEqual(lastDaySpending.double, budgetValue)
    }
    
    func test_estimatedSpending_firstDaySpendingShouldNotBeZero() {
        fakeCalendar.nowToReturn = Date()
        fakeCalendar.daysInMonthRangeToReturn = 1...10
        let budgetValue = Double(1000)
        let firstDaySpending = sut.estimatedSpendings(budgetValue: budgetValue).first!.value
        XCTAssertTrue(firstDaySpending.double != 0)
        XCTAssertEqual(firstDaySpending.double, 100)
    }
    
}
