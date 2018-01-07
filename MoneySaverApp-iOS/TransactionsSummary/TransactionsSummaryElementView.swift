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
        setupLayer(borderWidth: 0)
        let titleLabel = createLabel()
        titleLabel.backgroundColor = Styles.yellowColor
        titleLabel.text = "title"
        
        let expensesLabel = createLabel()
        expensesLabel.backgroundColor = Styles.redColor
        expensesLabel.text = "expenses"
        
        let incomesLabel = createLabel()
        incomesLabel.backgroundColor = Styles.greenColor
        incomesLabel.text = "incomes"
        
        let totalLabel = createLabel()
        totalLabel.backgroundColor = Styles.yellowColor
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
    
    private func setupLayer(borderWidth: CGFloat) {
        layer.cornerRadius = 6
        layer.masksToBounds = true
        layer.borderColor = UIColor.red.cgColor
        layer.borderWidth = borderWidth
    }

    private func createLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.minimumScaleFactor = 0.5
        return label
    }
    
    func update(withViewModel viewModel: TransactionsSummaryElementViewModel) {
        titleLabel?.text = viewModel.title
        incomesLabel?.text = viewModel.incomes
        expensesLabel?.text = viewModel.expenses
        totalLabel?.text = viewModel.total
    }
    
    var isSelected: Bool = false {
        didSet {
            setupLayer(borderWidth: isSelected ? 2 : 0)
        }
    }
    
}
