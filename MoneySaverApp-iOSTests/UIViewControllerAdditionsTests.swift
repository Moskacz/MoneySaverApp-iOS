//
//  UIViewControllerAdditionsTests.swift
//  MoneySaverApp-iOSTests
//
//  Created by Michal Moskala on 26.09.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import XCTest
@testable import MoneySaverApp_iOS

class UIViewControllerAdditionsTests: XCTestCase {
    
    func test_defaultStoryboardName_shouldEqualClassName() {
        XCTAssertEqual(UIViewController.defaultStoryboardIdentifier, "UIViewController")
    }
    
}
