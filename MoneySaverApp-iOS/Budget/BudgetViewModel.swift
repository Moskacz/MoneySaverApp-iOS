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
        return pieChartData(withTransactionsSum: computingService.transactionsSum())
    }
    
    private func pieChartData(withTransactionsSum sum: CompoundTransactionsSum) -> PieChartData {
        let spentMoneyEntry = PieChartDataEntry(value: sum.monthSum.double, label: "Spent")
        let leftSum = max(Double(3000) - sum.monthSum.double, 0)
        let leftMoneyEntry = PieChartDataEntry(value: leftSum, label: "Left")
        let dataSet = PieChartDataSet(values: [spentMoneyEntry, leftMoneyEntry], label: nil)
        dataSet.colors = [UIColor.red, UIColor.green]
        return PieChartData(dataSet: dataSet)
    }
}

extension BudgetViewModel: TransactionsComputingServiceDelegate {
    func sumUpdated(value: CompoundTransactionsSum) {
        delegate?.pieChartDataUpdated(pieChartData(withTransactionsSum: value))
    }
}
