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
        self.computingService.add(delegate: self)
        createInitialViewModels()
    }
    
    private func createInitialViewModels() {
        createViewModels(sum: computingService.sum())
    }
    
    private func createViewModels(sum: TransactionsCompoundSum) {
        self.viewModels = [DateIntervalCellViewModelImpl(sum: sum.daily, calendarService: calendarService),
                           DateIntervalCellViewModelImpl(sum: sum.weekly, calendarService: calendarService),
                           DateIntervalCellViewModelImpl(sum: sum.monthly, calendarService: calendarService),
                           DateIntervalCellViewModelImpl(sum: sum.yearly, calendarService: calendarService)]
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
    func sumUpdated(sum: TransactionsCompoundSum) {
        createViewModels(sum: sum)
    }
}
