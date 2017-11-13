//
//  DateIntervalPickerViewModel.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 03.11.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation

protocol DateIntervalPickerViewModelDelegate: class {
    func reloadView()
}

class DateIntervalPickerViewModel {
    
    private let calendarService: CalendarService
    private var computingService: TransactionsComputingService
    private var viewModels = [DateIntervalCellViewModel]()
    weak var delegate: DateIntervalPickerViewModelDelegate?
    
    init(calendarService: CalendarService, computingService: TransactionsComputingService) {
        self.calendarService = calendarService
        self.computingService = computingService
        self.computingService.delegate = self
        createInitialViewModels()
    }
    
    private func createInitialViewModels() {
        createViewModels(transactionSum: computingService.transactionsSum())
    }
    
    private func createViewModels(transactionSum: CompoundTransactionsSum) {
        let intervals: [DateIntervalType] = [.today, .currentWeek, .currentMonth, .currentYear]
        self.viewModels = intervals.flatMap { (type) in
            guard let interval = self.calendarService.dateInterval(forType: type) else { return nil }
            let typedInterval = TypedDateInterval(dateInterval: interval, type: type)
            return DateIntervalCellViewModelImpl(dateInterval: typedInterval,
                                                 sum: transactionSum.sum(forDateInterval: type))
        }
        self.delegate?.reloadView()
    }
    
    func numberOfIntervals() -> Int {
        return viewModels.count
    }
    
    func cellViewModel(forIndexPath path: IndexPath) -> DateIntervalCellViewModel {
        return viewModels[path.row]
    }
}

extension DateIntervalPickerViewModel: TransactionsComputingServiceDelegate {
    
    func sumUpdated(value: CompoundTransactionsSum) {
        createViewModels(transactionSum: value)
    }
}
