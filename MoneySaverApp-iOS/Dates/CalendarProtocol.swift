//
//  CalendarProtocol.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 13.01.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import Foundation

protocol CalendarProtocol {
    func structuredDate(forDate date: Date) -> StructuredDate
    func monthName(forDate date: Date) -> String
    func yearName(forDate date: Date) -> String
    func daysInMonth(forDate date: Date) -> Int
}

extension Calendar: CalendarProtocol {
    
    func monthName(forDate date: Date) -> String {
        let month = component(.month, from: date) - 1
        return standaloneMonthSymbols[month].firstUppercased
    }
    
    func yearName(forDate date: Date) -> String {
        return String(component(.year, from: date))
    }
    
    func daysInMonth(forDate date: Date) -> Int {
        guard let range = range(of: .day, in: .month, for: date) else {
            return 0
        }
        
        return range.count
    }
}
