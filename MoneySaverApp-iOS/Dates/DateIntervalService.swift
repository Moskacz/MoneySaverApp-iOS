//
//  DateIntervalService.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 04.11.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation

protocol DateIntervalService {
    func todayDateInterval() -> DateInterval?
    func thisWeekDateInterval() -> DateInterval?
    func thisMonthDateInterval() -> DateInterval?
    func thisYearDateInterval() -> DateInterval?
}

class DateIntervalServiceImpl: DateIntervalService {
    
    private var calendar: Calendar
    private let dateProvider: CurrentDateProvider
    
    init(calendar: Calendar = Calendar.current,
         dateProvider: CurrentDateProvider = CurrentDateProviderImpl()) {
        self.calendar = calendar
        
        self.dateProvider = dateProvider
    }
    
    func todayDateInterval() -> DateInterval? {
        return calendar.dateInterval(of: .day, for: dateProvider.currentDate())
    }
    
    func thisWeekDateInterval() -> DateInterval? {
        return calendar.dateInterval(of: .weekOfMonth, for: dateProvider.currentDate())
    }
    
    func thisMonthDateInterval() -> DateInterval? {
        return calendar.dateInterval(of: .month, for: dateProvider.currentDate())
    }
    
    func thisYearDateInterval() -> DateInterval? {
        return calendar.dateInterval(of: .year, for: dateProvider.currentDate())
    }
}
