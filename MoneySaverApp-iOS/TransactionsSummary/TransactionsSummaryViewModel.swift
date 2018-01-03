//
//  TransactionsSummaryViewModel.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 09.12.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation

protocol TransactionsSummaryViewModelDelegate: class {
    func updateElement(viewModel: TransactionsSummaryElementViewModel,
                       dateComponent: TransactionDateComponent)
}


class TransactionsSummaryViewModel {
    
    weak var delegate: TransactionsSummaryViewModelDelegate? {
        didSet {
            createViewModels(withSum: computingService.sum())
        }
    }
    
    private let computingService: TransactionsComputingService
    private let calendarService: CalendarService
    
    init(computingService: TransactionsComputingService,
         calendarService: CalendarService) {
        self.computingService = computingService
        self.calendarService = calendarService
        computingService.add(delegate: self)
    }
    
    private func createViewModels(withSum sum: TransactionsCompoundSum) {
        delegate?.updateElement(viewModel: elementViewModel(sum: sum.daily),
                                dateComponent: .dayOfYear)
        delegate?.updateElement(viewModel: elementViewModel(sum: sum.weekly),
                                dateComponent: .weekOfYear)
        delegate?.updateElement(viewModel: elementViewModel(sum: sum.monthly),
                                dateComponent: .month)
        delegate?.updateElement(viewModel: elementViewModel(sum: sum.yearly),
                                dateComponent: .year)
    }
    
    private func elementViewModel(sum: TransactionsSum) -> TransactionsSummaryElementViewModel {
        return TransactionsSummaryElementViewModelImpl(transactionsSum: sum,
                                                       calendarService: calendarService)
    }
    
}

extension TransactionsSummaryViewModel: TransactionsComputingServiceDelegate {
    
    func transactionsSumUpdated(_ sum: TransactionsCompoundSum) {
        createViewModels(withSum: sum)
    }
    
    func monthlyExpensesUpdated(_ expenses: [DailyValue]) {}
}
