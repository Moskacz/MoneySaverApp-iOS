import Foundation
import CoreData

class StatsViewModel {
    
    var availableGroupings: [TransactionsGrouping] = [.day, .week, .month]
    var selectedGrouping: Int = 2 {
        didSet {
            print(availableGroupings[selectedGrouping])
        }
    }
    
    private let repository: TransactionsRepository
    
    
    init(repository: TransactionsRepository) {
        self.repository = repository
    }
}

