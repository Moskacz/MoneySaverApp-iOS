import Foundation
import CoreData
import MMFoundation
import MoneySaverAppCore

class StatsViewModel {
    
    var availableGroupings: [TransactionsGrouping] = [.dayOfEra, .weekOfEra, .monthOfEra]
    var selectedSegmentIndex: Int {
        didSet {
            let selectedGrouping = availableGroupings[selectedSegmentIndex]
            userPreferences.statsGrouping = selectedGrouping
        }
    }
    
    private let repository: TransactionsRepository
    private let dataProcessor: ChartsDataProcessor
    private let userPreferences: UserPreferences
    
    init(repository: TransactionsRepository,
         dataProcessor: ChartsDataProcessor,
         userPreferences: UserPreferences) {
        self.repository = repository
        self.dataProcessor = dataProcessor
        self.userPreferences = userPreferences
        self.selectedSegmentIndex = self.availableGroupings.index(of: userPreferences.statsGrouping)!
    }
    
    var segmentedControlItems: [UISegmentedControl.Item] {
        return availableGroupings.map {
            UISegmentedControl.Item.text($0.description)
        }
    }
}

