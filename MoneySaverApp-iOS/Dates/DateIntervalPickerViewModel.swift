//
//  DateIntervalPickerViewModel.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 03.11.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation

class DateIntervalPickerViewModel {
    
    private let dateIntervalService: DateIntervalService
    
    init(dateIntervalService: DateIntervalService) {
        self.dateIntervalService = dateIntervalService
    }
    
    private lazy var viewModels: [DateIntervalCellViewModel] = {
        let intervals: [DateIntervalLabel] = [.today, .currentWeek, .currentMonth, .currentYear]
        return intervals.flatMap { (label) -> LabeledDateInterval? in
            guard let interval = self.dateIntervalService.dateInterval(forLabel: label) else { return nil }
            return LabeledDateInterval(dateInterval: interval, label: label)
        }.map {
            return DateIntervalCellViewModelImpl(dateInterval: $0, sum: Decimal(0))
        }
    }()
    
    func numberOfIntervals() -> Int {
        return viewModels.count
    }
    
    func cellViewModel(forIndexPath path: IndexPath) -> DateIntervalCellViewModel {
        return viewModels[path.row]
    }
}
