//
//  FakeChartsDataProcessor.swift
//  MoneySaverApp-iOSTests
//
//  Created by Michal Moskala on 18.04.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import Foundation
@testable import MoneySaverApp_iOS

class FakeChartsDataProcessor: ChartsDataProcessor {
    
    func spendings(fromMonthlyExpenses expenses: [DatedValue]) -> [PlotValue] {
        fatalError()
    }
    
    func estimatedSpendings(budgetValue: Double) -> [PlotValue] {
        fatalError()
    }
    
    
}
