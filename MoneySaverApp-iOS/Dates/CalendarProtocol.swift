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
    
    
}
