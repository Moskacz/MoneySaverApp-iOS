//
//  FakeCalendar.swift
//  MoneySaverApp-iOSTests
//
//  Created by Michal Moskala on 13.01.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import Foundation
@testable import MoneySaverApp_iOS

class FakeCalendar: CalendarProtocol {
    
    var nowToReturn: Date!
    var daysInMonthRangeToReturn: CountableClosedRange<Int>!
    
    var now: Date {
        return nowToReturn
    }
    
    func daysInMonthRange(forDate date: Date) -> CountableClosedRange<Int> {
        return daysInMonthRangeToReturn
    }
    
    func daysInMonth(forDate date: Date) -> Int {
        fatalError()
    }
    
    func structuredDate(forDate date: Date) -> StructuredDate {
        fatalError()
    }
    
    func monthName(forDate date: Date) -> String {
        fatalError()
    }
    
    func yearName(forDate date: Date) -> String {
        fatalError()
    }
}
