//
//  CalendarProtocol.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 13.01.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import Foundation

protocol CalendarProtocol {
    func structuredDate(forDate date: Date) -> StructuredDate
    func monthName(forDate date: Date) -> String
    func yearName(forDate date: Date) -> String
}

extension Calendar: CalendarProtocol {}
