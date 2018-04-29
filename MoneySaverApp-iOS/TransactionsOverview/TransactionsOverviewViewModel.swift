//
//  TransactionsOverviewViewModel.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 02.04.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import Foundation
import MoneySaverAppCore

final class TransactionsOverviewViewModel {
    
    lazy var listViewModel: TransactionsListViewModel = {
        return TransactionsListViewModel(repository: repository,
                                         logger: logger,
                                         calendar: calendar,
                                         timeChangedObserver: timeChangedObserver,
                                         dateRange: dateRange)
    }()
    
    lazy var summaryViewModel: TransactionsSummaryViewModel = {
        return TransactionsSummaryViewModel(computingService: computingService,
                                            dateRange: dateRange)
    }()
    
    var dateRange: DateRange {
        didSet {
            listViewModel.dateRange = dateRange
            summaryViewModel.dateRange = dateRange
        }
    }
    
    private let repository: TransactionsRepository
    private let logger: Logger
    private let calendar: CalendarProtocol
    private let timeChangedObserver: TimeChangedObserver
    private let computingService: TransactionsComputingService
    
    init(repository: TransactionsRepository,
         logger: Logger,
         calendar: CalendarProtocol,
         timeChangedObserver: TimeChangedObserver,
         computingService: TransactionsComputingService,
         dateRange: DateRange) {
        self.repository = repository
        self.logger = logger
        self.calendar = calendar
        self.timeChangedObserver = timeChangedObserver
        self.computingService = computingService
        self.dateRange = dateRange
    }
}
