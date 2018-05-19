//
//  TransactionTypePickerViewTests.swift
//  MoneySaverApp-iOSTests
//
//  Created by Michal Moskala on 19.05.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import XCTest
@testable import MoneySaverApp_iOS

class TransactionTypePickerViewTests: XCTestCase {
    
    var sut: TransactionTypePickerView!
    
    override func setUp() {
        super.setUp()
        sut = TransactionTypePickerView.makeView()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_makeView() {
        XCTAssertNotNil(TransactionTypePickerView.makeView())
    }
    
    func test_buttonsBackgorundColors() {
        XCTAssertEqual(sut.incomeButton!.backgroundColor, AppColor.green.value)
        XCTAssertEqual(sut.expenseButton!.backgroundColor, AppColor.red.value)
    }
    
    func test_selectedType_matchingButtonShouldBeFullyVisible() {
        sut.selectedType = TransactionType.income
        XCTAssertEqual(sut.incomeButton!.alpha, 1.0, accuracy: 0.01)
        XCTAssertEqual(sut.expenseButton!.alpha, 0.3, accuracy: 0.01)
        
        sut.selectedType = TransactionType.expense
        XCTAssertEqual(sut.incomeButton!.alpha, 0.3, accuracy: 0.01)
        XCTAssertEqual(sut.expenseButton!.alpha, 1.0, accuracy: 0.01)
        
        sut.selectedType = nil
        XCTAssertEqual(sut.incomeButton!.alpha, 0.3, accuracy: 0.01)
        XCTAssertEqual(sut.expenseButton!.alpha, 0.3, accuracy: 0.01)
    }
    
    func test_incomeButtonTapped_shouldSetSelectedType() {
        sut.incomeButtonTapped(sut.incomeButton!)
        XCTAssertEqual(sut.selectedType!, TransactionType.income)
    }
    
    func test_expenseButtonTapped_shouldSetSelectedType() {
        sut.expenseButtonTapped(sut.expenseButton!)
        XCTAssertEqual(sut.selectedType!, TransactionType.expense)
    }
}
