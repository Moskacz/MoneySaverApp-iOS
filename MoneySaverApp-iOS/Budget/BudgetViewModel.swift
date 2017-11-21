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
    weak var delegate: BudgetViewModelDelegate?
    
    init(computingService: TransactionsComputingService) {
        self.computingService = computingService
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
        return combinedChartData(transactionsValue: computingService.sum().monthly.total())
    }
    
    private func combinedChartData(transactionsValue: Decimal) -> CombinedChartData {
        let data = CombinedChartData()
        let daysInMonth = 30
        let valuePerDay = budgetValue() / Double(daysInMonth)
        let barEntries = (0...daysInMonth).map { BarChartDataEntry(x: Double($0), y: valuePerDay * Double($0))}
        let barDataSet = BarChartDataSet(values: barEntries, label: "Estimated spendings")
        data.barData = BarChartData(dataSet: barDataSet)
        return data
    }
    
    private func budgetValue() -> Double {
        return 3000
    }
}

extension BudgetViewModel: TransactionsComputingServiceDelegate {
    func sumUpdated(sum: TransactionsCompoundSum) {
        delegate?.pieChartDataUpdated(pieChartData(expenses: sum.monthly.expenses))
        delegate?.combinedChartDataUpdated(combinedChartData(transactionsValue: sum.monthly.total()))
    }
}
