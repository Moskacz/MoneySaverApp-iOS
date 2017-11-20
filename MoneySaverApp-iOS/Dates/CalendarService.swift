//
//  DateIntervalService.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 04.11.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation

enum DateIntervalType {
    case today
    case currentWeek
    case currentMonth
    case currentYear
}

struct TypedDateInterval {
    let dateInterval: DateInterval
    let type: DateIntervalType
}

protocol CalendarService {
    func dateInterval(forType type: DateIntervalType) -> DateInterval?
    func year(ofDate date: Date) -> Int
    func month(ofDate date: Date) -> Int
    func weekOfYear(ofDate date: Date) -> Int
    func day(ofDate date: Date) -> Int
    func dayOfYear(ofDate date: Date) -> Int
}

class CalendarServiceImpl: CalendarService {
    
    private var calendar: Calendar
    private let dateProvider: CurrentDateProvider
    
    init(calendar: Calendar = Calendar.current,
         dateProvider: CurrentDateProvider = CurrentDateProviderImpl()) {
        self.calendar = calendar
        self.dateProvider = dateProvider
    }
    
    func dateInterval(forType type: DateIntervalType) -> DateInterval? {
        switch type {
        case .today:
            return calendar.dateInterval(of: .day, for: dateProvider.currentDate())
        case .currentWeek:
            return calendar.dateInterval(of: .weekOfMonth, for: dateProvider.currentDate())
        case .currentMonth:
            return calendar.dateInterval(of: .month, for: dateProvider.currentDate())
        case .currentYear:
            return calendar.dateInterval(of: .year, for: dateProvider.currentDate())
        }
    }
    
    func year(ofDate date: Date) -> Int {
        return calendar.component(.year, from: date)
    }
    
    func month(ofDate date: Date) -> Int {
        return calendar.component(.month, from: date)
    }
    
    func weekOfYear(ofDate date: Date) -> Int {
        return calendar.component(.weekOfYear, from: date)
    }
    
    func day(ofDate date: Date) -> Int {
        return calendar.component(.day, from: date)
    }
    
    func dayOfYear(ofDate date: Date) -> Int {
        return calendar.ordinality(of: .day, in: .year, for: date) ?? 0
    }
    
}
