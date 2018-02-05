//
//  TransactionCellViewModelTests.swift
//  MoneySaverApp-iOSTests
//
//  Created by Michal Moskala on 04.02.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import XCTest

@testable import MoneySaverApp_iOS

class TransactionCellViewModelTests: XCTestCase {
    
    func test_titleText() {
        let transaction = FakeTransaction()
        transaction.value = NSDecimalNumber(value: 100)
        let sut = TransactionCellViewModelImplementation(transaction: transaction)
        XCTAssertEqual(sut.titleText(), "100")
    }
    
    func test_descriptionText() {
        let transaction = FakeTransaction()
        transaction.title = "testTitle"
        let sut = TransactionCellViewModelImplementation(transaction: transaction)
        XCTAssertEqual(sut.descriptionText(), "testTitle")
    }
    
}
