//
//  TransactionDataViewModelTests.swift
//  MoneySaverApp-iOSTests
//
//  Created by Michal Moskala on 10.10.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import XCTest
@testable import MoneySaverApp_iOS

class TransactionDataViewModelTests: XCTestCase {
    
    var sut: TransactionDataViewModel!
    
    override func setUp() {
        super.setUp()
        sut = TransactionDataViewModel()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_data_whenNilTitle_thenShouldThrowError() {
        sut.transactionTitle = nil
        sut.transactionValue = "10"
        do {
            _ = try sut.data()
        } catch {
            XCTAssertEqual(error as! TransactionDataFormError, TransactionDataFormError.missingTitle)
        }
    }
    
    func test_data_whenNilValue_thenShouldThrowError() {
        sut.transactionTitle = "some_title"
        sut.transactionValue = nil
        do {
            _ = try sut.data()
        } catch {
            XCTAssertEqual(error as! TransactionDataFormError, TransactionDataFormError.missingValue)
        }
    }
    
    func test_data_whenNonNumberValue_thenShouldThrowError() {
        sut.transactionTitle = "some_title"
        sut.transactionValue = "1xx0"
        do {
            _ = try sut.data()
        } catch {
            XCTAssertEqual(error as! TransactionDataFormError, TransactionDataFormError.invalidValue)
        }
    }
}
