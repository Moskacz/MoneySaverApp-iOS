//
//  TransactionsSummaryElementView.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 09.12.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import UIKit

class TransactionSummaryElementView: UIStackView {
    
    @IBOutlet private weak var titleLabel: UILabel?
    @IBOutlet private weak var incomesLabel: UILabel?
    @IBOutlet private weak var expensesLabel: UILabel?
    @IBOutlet private weak var totalLabel: UILabel?
    
    func update(withViewModel viewModel: TransactionsSummaryElementViewModel) {
        titleLabel?.text = viewModel.title
        incomesLabel?.text = viewModel.incomes
        expensesLabel?.text = viewModel.expenses
        totalLabel?.text = viewModel.total
    }
    
}
