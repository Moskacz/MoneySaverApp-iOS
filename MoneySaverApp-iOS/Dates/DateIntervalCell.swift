//
//  DateIntervalCell.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 03.11.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import UIKit

protocol DateIntervalCellViewModel {
    func intervalTitle() -> String?
    func incomesSum() -> String?
    func expensesSum() -> String?
    func totalSum() -> String?
}

class DateIntervalCell: UICollectionViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel?
    @IBOutlet private weak var incomesSumLabel: UILabel?
    @IBOutlet private weak var expensesSumLabel: UILabel?
    @IBOutlet private weak var totalSumLabel: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    private func setupView() {
        layer.cornerRadius = 16
    }
    
    func update(withViewModel viewModel: DateIntervalCellViewModel) {
        titleLabel?.text = viewModel.intervalTitle()
        incomesSumLabel?.text = viewModel.incomesSum()
        expensesSumLabel?.text = viewModel.expensesSum()
        totalSumLabel?.text = viewModel.totalSum()
    }
}
