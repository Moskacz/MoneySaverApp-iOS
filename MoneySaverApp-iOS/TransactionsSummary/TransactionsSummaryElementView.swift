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
        
        let expensesLabel = createLabel()
        expensesLabel.backgroundColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1).withAlphaComponent(0.1)
        expensesLabel.text = "expenses"
        
        let incomesLabel = createLabel()
        incomesLabel.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1).withAlphaComponent(0.1)
        incomesLabel.text = "incomes"
        
        let totalLabel = createLabel()
        totalLabel.text = "total"
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, expensesLabel, incomesLabel, totalLabel])
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
