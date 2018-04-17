import Foundation
import CoreData
import MMFoundation

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
    
    var segmentedControlItems: [UISegmentedControl.Item] {
        return availableGroupings.map {
            UISegmentedControl.Item.text($0.description)
        }
    }
}

