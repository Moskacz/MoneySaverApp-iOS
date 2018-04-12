//
//  SequenceTests.swift
//  MoneySaverApp-iOSTests
//
//  Created by Michal Moskala on 30.01.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import XCTest
@testable import MoneySaverApp_iOS

class SequenceTests: XCTestCase {
    
    func test_grouped() {
        let person1 = Person(name: "Jan", age: 30)
        let person2 = Person(name: "Pawel", age: 20)
        let person3 = Person(name: "Michal", age: 25)
        let person4 = Person(name: "Piotr", age: 25)
        let persons = [person1, person2, person3, person4]
        
        let grouped = persons.grouped { $0.age }
        XCTAssertEqual(grouped[30]!, [person1])
        XCTAssertEqual(grouped[20]!, [person2])
        XCTAssertEqual(grouped[25]!, [person3, person4])
    }
    
    func test_compoundSum_shouldComputeSumForGivenDate() {
        let today = FakeCalendarDate()
        today.dayOfEra = 1
        today.weekOfEra = 2
        today.monthOfEra = 3
        today.year = 2018
        
        let todayTransaction = FakeTransaction()
        todayTransaction.transactionDate = today
        todayTransaction.value = NSDecimalNumber(value: 20)
        
        let yesterday = FakeCalendarDate()
        yesterday.dayOfEra = 0
        yesterday.weekOfEra = 2
        yesterday.monthOfEra = 3
        yesterday.year = 2018
        
        let yesterdayTransaction = FakeTransaction()
        yesterdayTransaction.transactionDate = yesterday
        yesterdayTransaction.value = NSDecimalNumber(value: 10)
        
        let compoundSum = [todayTransaction, yesterdayTransaction].compoundSum(date: today)
        XCTAssertEqual(compoundSum.daily.incomes.double, 20) // only today
        XCTAssertEqual(compoundSum.weekly.incomes.double, 30) // both
        XCTAssertEqual(compoundSum.monthly.incomes.double, 30) // both
        XCTAssertEqual(compoundSum.yearly.incomes.double, 30) // both
        XCTAssertEqual(compoundSum.era.incomes.double, 30) // both
    }
    
}

private struct Person {
    let name: String
    let age: Int
}

extension Person: Equatable {
    static func ==(lhs: Person, rhs: Person) -> Bool {
        return lhs.name == rhs.name && lhs.age == rhs.age
    }
}
