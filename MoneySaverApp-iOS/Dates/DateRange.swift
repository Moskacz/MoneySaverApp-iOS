//
//  DateRange.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 07.01.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import Foundation

enum DateRange: String {
    case today
    case thisWeek
    case thisMonth
    case thisYear
    case allTime
}

extension DateRange: CustomStringConvertible {
    
    var description: String {
        switch self {
        case .today: return "Today"
        case .thisWeek: return "Weekly"
        case .thisMonth: return "Monthly"
        case .thisYear: return "Year"
        case .allTime: return "All"
        }
    }
}
