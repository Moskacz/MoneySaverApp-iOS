//
//  TransactionGrouping.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 02.02.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import Foundation

enum TransactionGrouping {
    case day
    case week
    case month
    
    var title: String {
        switch self {
        case .day:
            return "Dzień"
        case .week:
            return "Tydzień"
        case .month:
            return "Miesiąc"
        }
    }
}
