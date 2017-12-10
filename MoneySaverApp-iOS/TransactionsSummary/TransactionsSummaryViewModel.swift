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
    
    init(computingService: TransactionsComputingService) {
        self.computingService = computingService
        computingService.add(delegate: self)
    }
    
    private func createViewModels(withSum sum: TransactionsCompoundSum) {
        delegate?.updateElement(viewModel: TransactionsSummaryElementViewModelImpl(transactionsSum: sum.daily),
                                dateComponent: .day)
        delegate?.updateElement(viewModel: TransactionsSummaryElementViewModelImpl(transactionsSum: sum.weekly),
                                dateComponent: .weekOfYear)
        delegate?.updateElement(viewModel: TransactionsSummaryElementViewModelImpl(transactionsSum: sum.monthly),
                                dateComponent: .month)
        delegate?.updateElement(viewModel: TransactionsSummaryElementViewModelImpl(transactionsSum: sum.yearly),
                                dateComponent: .year)
    }
    
}

extension TransactionsSummaryViewModel: TransactionsComputingServiceDelegate {
    
    func transactionsSumUpdated(_ sum: TransactionsCompoundSum) {
        createViewModels(withSum: sum)
    }
    
    func monthlyExpensesUpdated(_ expenses: [DailyValue]) {}
}
