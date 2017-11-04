//
//  DateIntervalService.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 04.11.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation

protocol DateIntervalService {
    func dateInterval(forLabel label: DateIntervalLabel) -> DateInterval?
}

enum DateIntervalLabel {
    case today
    case currentWeek
    case currentMonth
    case currentYear
}

struct LabeledDateInterval {
    let dateInterval: DateInterval
    let label: DateIntervalLabel
}

class DateIntervalServiceImpl: DateIntervalService {
    
    private var calendar: Calendar
    private let dateProvider: CurrentDateProvider
    
    init(calendar: Calendar = Calendar.current,
         dateProvider: CurrentDateProvider = CurrentDateProviderImpl()) {
        self.calendar = calendar
        self.dateProvider = dateProvider
    }
    
    func dateInterval(forLabel label: DateIntervalLabel) -> DateInterval? {
        switch label {
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
}
