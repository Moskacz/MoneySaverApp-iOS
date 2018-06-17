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
    private let dataProcessor: StatsChartsDataProcessor
    private let userPreferences: UserPreferences
    
    init(repository: TransactionsRepository,
         dataProcessor: StatsChartsDataProcessor,
         userPreferences: UserPreferences) {
        self.repository = repository
        self.dataProcessor = dataProcessor
        self.userPreferences = userPreferences
        self.selectedSegmentIndex = self.availableGroupings.index(of: userPreferences.statsGrouping)!
    }
    
    var segmentedControlItems: [SegmentedControlItem] {
        return availableGroupings.map {
            SegmentedControlItem.text($0.description)
        }
    }
}

