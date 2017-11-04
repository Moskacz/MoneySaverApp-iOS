//
//  DateIntervalCellViewModelImpl.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 04.11.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation

class DateIntervalCellViewModelImpl: DateIntervalCellViewModel {
    
    private let dateInterval: LabeledDateInterval
    private let sum: Decimal

    init(dateInterval: LabeledDateInterval, sum: Decimal) {
        self.dateInterval = dateInterval
        self.sum = sum
    }
    
    func intervalTitle() -> String? {
        switch dateInterval.label {
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
        return nil
    }
    
    func transactionsSum() -> String? {
        return "\(sum)"
    }
}
