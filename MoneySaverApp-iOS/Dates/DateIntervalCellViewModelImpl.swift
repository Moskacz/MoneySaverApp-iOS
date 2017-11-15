//
//  DateIntervalCellViewModelImpl.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 04.11.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation

class DateIntervalCellViewModelImpl: DateIntervalCellViewModel {
    
    private let dateInterval: TypedDateInterval
    private let sum: Decimal

    init(dateInterval: TypedDateInterval, sum: Decimal) {
        self.dateInterval = dateInterval
        self.sum = sum
    }
    
    func intervalTitle() -> String? {
        switch dateInterval.type {
        case .today:
            return "Today"
        case .currentWeek:
            return "Week"
        case .currentMonth:
            return "Month"
        case .currentYear:
            return "Year"
        }
    }
    
    func intervalDescription() -> String? {
        switch dateInterval.type {
        case .today, .currentWeek:
            return nil
        case .currentMonth:
            let formatter = DateFormatters.formatter(forType: .monthOnly)
            return formatter.string(from: dateInterval.dateInterval.start)
        case .currentYear:
            let formatter = DateFormatters.formatter(forType: .yearOnly)
            return formatter.string(from: dateInterval.dateInterval.start)
        }
    }
    
    func transactionsSum() -> String? {
        return "\(sum)"
    }
}