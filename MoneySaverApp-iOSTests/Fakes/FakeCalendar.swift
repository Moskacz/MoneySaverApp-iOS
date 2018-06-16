//
//  FakeCalendar.swift
//  MoneySaverApp-iOSTests
//
//  Created by Michal Moskala on 13.01.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import Foundation
import MoneySaverAppCore

class FakeCalendar: CalendarProtocol {
    
    var nowToReturn: Date!
    var daysInMonthRangeToReturn: CountableClosedRange<Int>!
    var dayOfEraOfDateToReturn: Int!
    var weekOfEraOfDateToReturn: Int!
    var monthOfEraOfDateToReturn: Int!
    var yearOfDateToReturn: Int!
    var monthNameToReturn: String!
    var yearNameToReturn: String!
    var beginEndDaysOfWeekToReturn: (Date, Date)!
    
    var now: Date {
        return nowToReturn
    }
    
    var nowCalendarDate: CalendarDate {
        fatalError()
    }
    
    func calendarDate(from date: Date) -> CalendarDate {
        fatalError()
    }
    
    func dayOfEraOf(date: Date) -> Int {
        return dayOfEraOfDateToReturn
    }
    
    func weekOfEraOf(date: Date) -> Int {
        return weekOfEraOfDateToReturn
    }
    
    func monthOfEraOf(date: Date) -> Int {
        return monthOfEraOfDateToReturn
    }
    
    func yearOf(date: Date) -> Int {
        return yearOfDateToReturn
    }
    
    func daysInMonthRange(forDate date: Date) -> CountableClosedRange<Int> {
        return daysInMonthRangeToReturn
    }
    
    func daysInMonth(forDate date: Date) -> Int {
        fatalError()
    }
    
    func monthName(forDate date: Date) -> String {
        return monthNameToReturn
    }
    
    func yearName(forDate date: Date) -> String {
        return yearNameToReturn
    }

    
    func beginEndDaysOfWeek(forDate date: Date) -> (start: Date, end: Date) {
        return beginEndDaysOfWeekToReturn
    }
}
