//
//  DateIntervalPickerViewModel.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 03.11.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation

class DateIntervalPickerViewModel {
    
    func numberOfIntervals() -> Int {
        return 3
    }
    
    func cellViewModel(forIndexPath path: IndexPath) -> DateIntervalCellViewModel {
        return TestViewModel()
    }
}

class TestViewModel: DateIntervalCellViewModel {
    func intervalTitle() -> String? {
        return "Today"
    }
    
    func intervalDescription() -> String? {
        return nil
    }
    
    func transactionsSum() -> String? {
        return "250$"
    }
}
