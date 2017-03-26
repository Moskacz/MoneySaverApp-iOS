//
//  TransactionsRouterTests.swift
//  RESTClient
//
//  Created by Michał Moskała on 23.03.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import XCTest
@testable import RESTClient

class TransactionsRouterTests: XCTestCase {
    
    var sut: TransactionsRouter!
    
    override func setUp() {
        super.setUp()
        let basePath = URL(string: "https://myserver:3000")!
        sut = TransactionsRouter(baseURL: basePath)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_getAllPath() {
        let path = sut.getAllURL()
        let expectedURL = URL(string: "https://myserver:3000/transactions")!
        XCTAssert(path == expectedURL)
    }
    
    func test_postPath() {
        let path = sut.postURL(entityID: "fakeId")
        let expectedURL = URL(string: "https://myserver:3000/transactions/fakeId")!
        XCTAssert(path == expectedURL)
    }
    
    func test_putPath() {
        let path = sut.putURL(entityID: "fakeId")
        let expectedURL = URL(string: "https://myserver:3000/transactions/fakeId")!
        XCTAssert(path == expectedURL)
    }
    
    func test_deletePath() {
        let path = sut.deleteURL(entityID: "fakeId")
        let expectedURL = URL(string: "https://myserver:3000/transactions/fakeId")!
        XCTAssert(path == expectedURL)
    }
}
