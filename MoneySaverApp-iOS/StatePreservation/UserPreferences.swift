//
//  UserPreferences.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 08.04.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import Foundation

protocol UserPreferences: class {
    var dateRange: DateRange { get set }
}

extension UserDefaults: UserPreferences {
    
    enum PreferenceKey: String {
        case dateRange = "userPreferences_dateRange"
    }
    
    var dateRange: DateRange {
        get {
            let defaultValue = DateRange.allTime
            guard let rawValue = string(forKey: PreferenceKey.dateRange.rawValue) else {
                return defaultValue
            }
            return DateRange(rawValue: rawValue) ?? defaultValue
        }
        set {
            set(newValue.rawValue, forKey: PreferenceKey.dateRange.rawValue)
            synchronize()
        }
    }
}
