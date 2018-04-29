import Foundation
import CoreData
import MMFoundation
import MoneySaverAppCore

class StatsViewModel {
    
    var availableGroupings: [TransactionsGrouping] = [.day, .week, .month]
    var selectedGrouping: Int = 2 {
        didSet {
            print(availableGroupings[selectedGrouping])
        }
    }
    
    private let repository: TransactionsRepository
    private let dataProcessor: ChartsDataProcessor
    
    init(repository: TransactionsRepository, dataProcessor: ChartsDataProcessor) {
        self.repository = repository
        self.dataProcessor = dataProcessor
    }
    
    var segmentedControlItems: [UISegmentedControl.Item] {
        return availableGroupings.map {
            UISegmentedControl.Item.text($0.description)
        }
    }
}

