//
//  Calendar+Additions.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 10.01.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import Foundation

extension Calendar {
    
    func monthName(forDate date: Date) -> String {
        let month = component(.month, from: date) - 1
        return standaloneMonthSymbols[month].firstUppercased
    }
    
    func yearName(forDate date: Date) -> String {
        return String(component(.year, from: date))
    }
    
}
