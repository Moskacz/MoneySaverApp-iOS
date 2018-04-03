//
//  TransactionsOverviewViewModel.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 02.04.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import Foundation

final class TransactionsOverviewViewModel {
    
    private let repository: TransactionsRepository
    private let logger: Logger
    private let calendar: CalendarProtocol
    private let timeChangedObserver: TimeChangedObserver
    private let computingService: TransactionsComputingService
    
    init(repository: TransactionsRepository,
         logger: Logger,
         calendar: CalendarProtocol,
         timeChangedObserver: TimeChangedObserver,
         computingService: TransactionsComputingService) {
        self.repository = repository
        self.logger = logger
        self.calendar = calendar
        self.timeChangedObserver = timeChangedObserver
        self.computingService = computingService
    }
    
    var listViewModel: TransactionsListViewModel {
        return TransactionsListViewModel(repository: repository,
                                         logger: logger,
                                         calendar: calendar,
                                         timeChangedObserver: timeChangedObserver)
    }
    
    var summaryViewModel: TransactionsSummaryViewModel {
        return TransactionsSummaryViewModel(computingService: computingService)
    }
}
