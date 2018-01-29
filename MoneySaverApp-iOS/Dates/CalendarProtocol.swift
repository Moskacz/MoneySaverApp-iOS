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
    func dayOfEraOf(date: Date) -> Int
    func weekOfEraOf(date: Date) -> Int
    func monthOfEraOf(date: Date) -> Int
    func yearOf(date: Date) -> Int
    func structuredDate(forDate date: Date) -> StructuredDate
    func monthName(forDate date: Date) -> String
    func yearName(forDate date: Date) -> String
    func daysInMonthRange(forDate date: Date) -> CountableClosedRange<Int>
    func fillPropertiesOf(calendarDate: CalendarDate, withDate date: Date)
}

extension Calendar: CalendarProtocol {
    
    var now: Date {
        return Date()
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
    
    func fillPropertiesOf(calendarDate: CalendarDate, withDate date: Date) {
        calendarDate.calendarIdentifier = identifier.stringIdentifier
        calendarDate.timeInterval = date.timeIntervalSince1970
        calendarDate.dayOfWeek = Int32(component(.weekday, from: date))
        calendarDate.dayOfMonth = Int32(component(.day, from: date))
        calendarDate.dayOfYear = Int32(ordinality(of: .day, in: .year, for: date) ?? -1)
        calendarDate.dayOfEra = Int32(dayOfEraOf(date: date))
        calendarDate.weekOfMonth = Int32(component(.weekOfMonth, from: date))
        calendarDate.weekOfYear = Int32(component(.weekOfYear, from: date))
        calendarDate.weekOfEra = Int32(weekOfEraOf(date: date))
        calendarDate.monthOfYear = Int32(component(.month, from: date))
        calendarDate.monthOfEra = Int32(ordinality(of: .month, in: .era, for: date) ?? -1)
        calendarDate.year = Int32(component(.year, from: date))
        calendarDate.era = Int32(component(.era, from: date))
    }
}
