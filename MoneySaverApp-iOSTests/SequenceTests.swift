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
    
    func test_compoundSum() {
        
        
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
