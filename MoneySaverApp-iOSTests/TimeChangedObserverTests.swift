//
//  TimeChangedHandlerTests.swift
//  MoneySaverApp-iOSTests
//
//  Created by Michal Moskala on 05.01.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import XCTest
@testable import MoneySaverApp_iOS

class TimeChangedObserverTests: XCTestCase {
    
    var notificationCenter: NotificationCenter!
    var sut: TimeChangedObserver!
    
    override func setUp() {
        super.setUp()
        notificationCenter = NotificationCenter()
        sut = TimeChangedObserver(notificationCenter: notificationCenter)
    }
    
    override func tearDown() {
        sut = nil
        notificationCenter = nil
        super.tearDown()
    }
    
    func test_whenSignificantTimeChangedNotificationIsPosted_thenDelegateMethodShouldBeCalled() {
        let delegate = FakeDelegate()
        sut.delegate = delegate
        notificationCenter.post(name: Notification.Name.UIApplicationSignificantTimeChange, object: nil)
        XCTAssertTrue(delegate.called)
    }
    
    class FakeDelegate: TimeChangedObserverDelegate {
        var called = false
        func timeChanged() {
            called = true
        }
    }
}
