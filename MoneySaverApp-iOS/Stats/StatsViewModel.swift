import Foundation
import Charts

class StatsViewModel {
    
    var availableGroupings: [TransactionGrouping] = [.day, .week, .month]
    var selectedGrouping: TransactionGrouping = TransactionGrouping.day
    
    func expensesData() -> BarChartData {
        return BarChartData()
    }
    
    func incomesData() -> BarChartData {
        return BarChartData()
    }
    
    func expensesPerCategoryData() -> BarChartData {
        return BarChartData()
    }
    
}
