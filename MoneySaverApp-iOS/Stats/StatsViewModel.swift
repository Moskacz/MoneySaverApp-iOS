import Foundation

class StatsViewModel {
    
    var availableGroupings: [TransactionGrouping] = [.day, .week, .month]
    var selectedGrouping: Int = 2 {
        didSet {
            print(availableGroupings[selectedGrouping])
        }
    }
    
    
}
