//
//  BudgetViewModel.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 15.11.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation
import Charts
import CoreData

protocol BudgetViewModelDelegate: class {
    func budget(setUp: Bool)
    func pieChartDataUpdated(_ data: PieChartData)
    func combinedChartDataUpdated(_ data: CombinedChartData)
}

class BudgetViewModel: NSObject {
    
    private let computingService: TransactionsComputingService
    private let dataProcessor: ChartsDataProcessor
    let budgetRepository: BudgetRepository
    private let service: BudgetService
    private var frc: NSFetchedResultsController<BudgetManagedObject>?
    weak var delegate: BudgetViewModelDelegate?
    
    init(computingService: TransactionsComputingService,
         dataProcessor: ChartsDataProcessor,
         budgetRepository: BudgetRepository,
         service: BudgetService) {
        self.computingService = computingService
        self.dataProcessor = dataProcessor
        self.budgetRepository = budgetRepository
        self.service = service
        super.init()
        
        fetchCurrentBudget()
        computingService.delegates.add(item: self)
    }
    
    private func fetchCurrentBudget() {
        frc = service.budgetFRC()
        frc?.delegate = self
        try? frc?.performFetch()
    }
    
    func isBudgetSetUp() -> Bool {
        guard let objects = frc?.fetchedObjects else {
            return false
        }
        return !objects.isEmpty
    }
    
    // MARK: Charts
    
    func pieChartData() -> PieChartData? {
        do {
            let sum = try computingService.sum()
            return pieChartData(expenses: sum.monthly.expenses)
        } catch {
            return nil
        }
    }
    
    private func pieChartData(expenses: Decimal) -> PieChartData {
        let spentMoneyEntry = PieChartDataEntry(value: -expenses.double, label: "Spent")
        let leftSum = max(budgetValue() + expenses.double, 0)
        let leftMoneyEntry = PieChartDataEntry(value: leftSum, label: "Left")
        let dataSet = PieChartDataSet(values: [spentMoneyEntry, leftMoneyEntry], label: nil)
        dataSet.colors = [UIColor.appRed, UIColor.appGreen]
        return PieChartData(dataSet: dataSet)
    }
    
    func combinedChartData() -> CombinedChartData? {
        do {
            let expenses = try computingService.monthlyExpenses()
            return combinedChartData(monthlyExpenses: expenses)
        } catch {
            return nil
        }
    }
    
    private func combinedChartData(monthlyExpenses: [DailyValue]) -> CombinedChartData {
        let data = CombinedChartData()
        
        let barEntries = dataProcessor.estimatedSpendings(budgetValue: budgetValue()).map {
            BarChartDataEntry(x: Double($0.day), y: $0.value.double)
        }
        let barDataSet = BarChartDataSet(values: barEntries, label: "Estimated spendings")
        barDataSet.colors = [UIColor.appGreen]
        barDataSet.drawValuesEnabled = false
        data.barData = BarChartData(dataSet: barDataSet)
        
        let lineEntries = dataProcessor.spendings(fromMonthlyExpenses: monthlyExpenses).map {
            return ChartDataEntry(x: Double($0.day), y: $0.value.double)
        }
        let lineDataSet = LineChartDataSet(values: lineEntries, label: "Actual spendings")
        lineDataSet.colors = [UIColor.appRed]
        lineDataSet.mode = .linear
        lineDataSet.lineWidth = 5
        lineDataSet.drawCirclesEnabled = false
        lineDataSet.drawValuesEnabled = false
        data.lineData = LineChartData(dataSet: lineDataSet)
        
        return data
    }
    
    private func budgetValue() -> Double {
        guard let budget = frc?.fetchedObjects?.first?.value else { return 0 }
        return budget.doubleValue
    }
}

extension BudgetViewModel: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        delegate?.budget(setUp: isBudgetSetUp())
    }
}

extension BudgetViewModel: TransactionsComputingServiceDelegate {
    func transactionsSumUpdated(_ sum: TransactionsCompoundSum) {
        delegate?.pieChartDataUpdated(pieChartData(expenses: sum.monthly.expenses))
    }
    
    func monthlyExpensesUpdated(_ expenses: [DailyValue]) {
        delegate?.combinedChartDataUpdated(combinedChartData(monthlyExpenses: expenses))
    }
}
