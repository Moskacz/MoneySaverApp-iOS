//
//  DateIntervalService.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 04.11.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation

enum TransactionDateComponent: String {
    case day
    case dayOfYear
    case weekOfYear
    case month
    case year
}

protocol CalendarService {
    func component(_ component: TransactionDateComponent, ofDate date: Date) -> Int
    func currentYearDescription() -> String
    func currentMonthDescription() -> String
}

class CalendarServiceImpl: CalendarService {
    
    private let calendar: Calendar
    private let currentDateProvider: CurrentDateProvider
    
    init(calendar: Calendar, currentDateProvider: CurrentDateProvider) {
        self.calendar = calendar
        self.currentDateProvider = currentDateProvider
    }
    
    func component(_ component: TransactionDateComponent, ofDate date: Date) -> Int {
        switch component {
        case .day:
            return calendar.component(.day, from: date)
        case .dayOfYear:
            return calendar.ordinality(of: .day, in: .year, for: date)!
        case .weekOfYear:
            return calendar.component(.weekOfYear, from: date)
        case .month:
            return calendar.component(.month, from: date)
        case .year:
            return calendar.component(.year, from: date)
        }
    }
    
    func currentYearDescription() -> String {
        return DateFormatters.formatter(forType: .yearOnly).string(from: now)
    }
    
    func currentMonthDescription() -> String {
        return DateFormatters.formatter(forType: .monthOnly).string(from: now)
    }
    
    private var now: Date {
        return currentDateProvider.currentDate()
    }
}
