//
//  CalendarProtocol.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 13.01.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import Foundation

protocol CalendarProtocol {
    var now: Date { get }
    var nowCalendarDate: CalendarDate { get }
    func dayOfEraOf(date: Date) -> Int
    func weekOfEraOf(date: Date) -> Int
    func monthOfEraOf(date: Date) -> Int
    func yearOf(date: Date) -> Int
    func monthName(forDate date: Date) -> String
    func yearName(forDate date: Date) -> String
    func daysInMonthRange(forDate date: Date) -> CountableClosedRange<Int>
    func beginEndDaysOfWeek(forDate date: Date) -> (start: Date, end: Date)
}

struct CalendarDate: CalendarDateProtocol {
    let calendarIdentifier: String?
    let dayOfEra: Int32
    let dayOfMonth: Int32
    let dayOfYear: Int32
    let era: Int32
    let weekOfEra: Int32
    let weekOfMonth: Int32
    let weekOfYear: Int32
    let year: Int32
    let timeInterval: Double
    let monthOfYear: Int32
    let monthOfEra: Int32
}

extension Calendar: CalendarProtocol {
    
    var now: Date {
        return Date()
    }
    
    var nowCalendarDate: CalendarDate {
        let date = now
        return CalendarDate(calendarIdentifier: identifier.stringIdentifier,
                            dayOfEra: Int32(dayOfEraOf(date: date)),
                            dayOfMonth: Int32(component(.day, from: date)),
                            dayOfYear: Int32(ordinality(of: .day, in: .year, for: date) ?? -1),
                            era: Int32(component(.era, from: date)),
                            weekOfEra: Int32(weekOfEraOf(date: date)),
                            weekOfMonth: Int32(component(.weekOfMonth, from: date)),
                            weekOfYear: Int32(component(.weekOfYear, from: date)),
                            year: Int32(component(.year, from: date)),
                            timeInterval: date.timeIntervalSince1970,
                            monthOfYear: Int32(component(.month, from: date)),
                            monthOfEra: Int32(ordinality(of: .month, in: .era, for: date) ?? -1))
    }
    
    func dayOfEraOf(date: Date) -> Int {
        return ordinality(of: .day, in: .era, for: date) ?? -1
    }
    
    func weekOfEraOf(date: Date) -> Int {
        return ordinality(of: .weekOfYear, in: .era, for: date) ?? -1
    }
    
    func monthOfEraOf(date: Date) -> Int {
        return ordinality(of: .month, in: .era, for: date) ?? -1
    }
    
    func yearOf(date: Date) -> Int {
        return component(.year, from: now)
    }
    
    func monthName(forDate date: Date) -> String {
        let month = component(.month, from: date) - 1;
        return standaloneMonthSymbols[month].firstUppercased
    }
    
    func yearName(forDate date: Date) -> String {
        return String(component(.year, from: date))
    }
    
    func daysInMonthRange(forDate date: Date) -> CountableClosedRange<Int> {
        guard let range = range(of: .day, in: .month, for: date) else {
            return 0...0
        }
        return CountableClosedRange(range)
    }
    
    func beginEndDaysOfWeek(forDate date: Date) -> (start: Date, end: Date) {
        var startDate: Date = Date()
        var interval: TimeInterval = 1
        _ = self.dateInterval(of: .weekOfMonth,
                              start: &startDate,
                              interval: &interval,
                              for: date)
        let endDate = startDate.addingTimeInterval(interval-1)
        return (startDate, endDate)
    }
}
