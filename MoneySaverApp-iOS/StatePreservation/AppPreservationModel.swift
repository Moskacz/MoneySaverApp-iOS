//
//  AppPreservationModel.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 16.01.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import Foundation

protocol AppPreservationModel {
    func save(dateRangeFilter filter: DateRange)
    var savedDateRangeFilter: DateRange? { get }
}

class AppPreservationModelImpl: AppPreservationModel {
    
    private let storage: KeyValueStorage
    private let dateRangeKey = "DateRange"
    
    init(storage: KeyValueStorage) {
        self.storage = storage
    }
    
    func save(dateRangeFilter filter: DateRange) {
        storage.set(filter.rawValue, forKey: dateRangeKey)
    }
    
    var savedDateRangeFilter: DateRange? {
        guard let storedValue = storage.value(forKey: dateRangeKey) as? String else {
            return nil
        }
        return DateRange(rawValue: storedValue)
    }
}


