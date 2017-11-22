//
//  BudgetViewModel.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 15.11.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation
import Charts

protocol BudgetViewModelDelegate: class {
    func pieChartDataUpdated(_ data: PieChartData)
    func combinedChartDataUpdated(_ data: CombinedChartData)
}

class BudgetViewModel {
    
    private let computingService: TransactionsComputingService
    private let dataProcessor: ChartsDataProcessor
    weak var delegate: BudgetViewModelDelegate?
    
    init(computingService: TransactionsComputingService, dataProcessor: ChartsDataProcessor) {
        self.computingService = computingService
        self.dataProcessor = dataProcessor
        self.computingService.add(delegate: self)
    }
    
    func pieChartData() -> PieChartData {
        return pieChartData(expenses: computingService.sum().monthly.expenses)
    }
    
    private func pieChartData(expenses: Decimal) -> PieChartData {
        let spentMoneyEntry = PieChartDataEntry(value: -expenses.double, label: "Spent")
        let leftSum = max(budgetValue() + expenses.double, 0)
        let leftMoneyEntry = PieChartDataEntry(value: leftSum, label: "Left")
        let dataSet = PieChartDataSet(values: [spentMoneyEntry, leftMoneyEntry], label: nil)
        dataSet.colors = [#colorLiteral(red: 1, green: 0.3717083335, blue: 0.3938803077, alpha: 1), #colorLiteral(red: 0, green: 0.7720543742, blue: 0, alpha: 1)]
        return PieChartData(dataSet: dataSet)
    }
    
    func combinedChartData() -> CombinedChartData {
        return combinedChartData(monthlyExpenses: computingService.monthlyExpenses())
    }
    
    private func combinedChartData(monthlyExpenses: [DailyValue]) -> CombinedChartData {
        let data = CombinedChartData()
        let daysInMonth = 30
        let daysRange = 0...daysInMonth
        let valuePerDay = budgetValue() / Double(daysInMonth)
        let barEntries = daysRange.map { BarChartDataEntry(x: Double($0), y: valuePerDay * Double($0))}
        let barDataSet = BarChartDataSet(values: barEntries, label: "Estimated spendings")
        barDataSet.colors = [#colorLiteral(red: 0, green: 0.7720543742, blue: 0, alpha: 1)]
        barDataSet.drawValuesEnabled = false
        data.barData = BarChartData(dataSet: barDataSet)
        
        let lineEntries = dataProcessor.spendings(fromMonthlyExpenses: monthlyExpenses).map {
            return ChartDataEntry(x: Double($0.day), y: $0.value.double)
        }
        let lineDataSet = LineChartDataSet(values: lineEntries, label: "Actual spendings")
        lineDataSet.colors = [#colorLiteral(red: 1, green: 0.3717083335, blue: 0.3938803077, alpha: 1)]
        
        lineDataSet.mode = .linear
        lineDataSet.lineWidth = 5
        lineDataSet.drawCirclesEnabled = false
        lineDataSet.drawValuesEnabled = false
        data.lineData = LineChartData(dataSet: lineDataSet)
        
        return data
    }
    
    private func budgetValue() -> Double {
        return 3000
    }
}

extension BudgetViewModel: TransactionsComputingServiceDelegate {
    func sumUpdated(sum: TransactionsCompoundSum) {
        delegate?.pieChartDataUpdated(pieChartData(expenses: sum.monthly.expenses))
//        delegate?.combinedChartDataUpdated(combinedChartData(transactionsValue: sum.monthly.total()))
    }
}
