//
//  DateIntervalService.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 04.11.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation

enum TransactionDateComponent: String {
    case dayOfWeek
    case dayOfMonth
    case dayOfYear
    case dayOfEra
    case weekOfYear
    case month
    case year
    case era
}

protocol CalendarService {
    func component(_ component: TransactionDateComponent, ofDate date: Date) -> Int
    var currentYearDescription: String { get }
    var currentMonthDescription: String { get }
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
        case .dayOfWeek:
            return calendar.component(.weekday, from: date)
        case .dayOfMonth:
            return calendar.component(.day, from: date)
        case .dayOfYear:
            return calendar.ordinality(of: .day, in: .year, for: date)!
        case .dayOfEra:
            return calendar.ordinality(of: .day, in: .era, for: date)!
        case .weekOfYear:
            return calendar.component(.weekOfYear, from: date)
        case .month:
            return calendar.component(.month, from: date)
        case .year:
            return calendar.component(.year, from: date)
        case .era:
            return calendar.component(.era, from: date)
        }
    }
    
    var currentYearDescription: String {
        return DateFormatters.formatter(forType: .yearOnly).string(from: now)
    }
    
    var currentMonthDescription: String {
        return DateFormatters.formatter(forType: .monthOnly).string(from: now)
    }
    
    private var now: Date {
        return currentDateProvider.currentDate()
    }
}
