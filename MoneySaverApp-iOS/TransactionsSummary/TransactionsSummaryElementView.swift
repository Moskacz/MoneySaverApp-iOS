//
//  TransactionsSummaryElementView.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 09.12.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import UIKit

class TransactionSummaryElementView: UIView {
    
    private weak var titleLabel: UILabel?
    private weak var incomesLabel: UILabel?
    private weak var expensesLabel: UILabel?
    private weak var totalLabel: UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        setupLayer()
        let titleLabel = createLabel()
        titleLabel.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        titleLabel.text = "title"
        
        let incomesLabel = createLabel()
        incomesLabel.text = "incomes"
        
        let expensesLabel = createLabel()
        expensesLabel.text = "expenses"
        
        let totalLabel = createLabel()
        totalLabel.text = "total"
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, incomesLabel, expensesLabel, totalLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        addSubview(stackView)
        stackView.matchParent()
        
        self.titleLabel = titleLabel
        self.incomesLabel = incomesLabel
        self.expensesLabel = expensesLabel
        self.totalLabel = totalLabel
    }
    
    private func setupLayer() {
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.lightGray.cgColor
        layer.cornerRadius = 6
        layer.masksToBounds = true
    }

    private func createLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }
    
    func update(withViewModel viewModel: TransactionsSummaryElementViewModel) {
        titleLabel?.text = viewModel.title
        incomesLabel?.text = viewModel.incomes
        expensesLabel?.text = viewModel.expenses
        totalLabel?.text = viewModel.total
    }
    
}
