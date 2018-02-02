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
        let titleLabel = createLabel()
        titleLabel.text = "title"
        
        let expensesLabel = createLabel()
        expensesLabel.text = "expenses"
        
        let incomesLabel = createLabel()
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
        
        setupLayer(borderWidth: 0)
        setupColors()
    }
    
    private func setupColors() {
        titleLabel?.backgroundColor = Styles.yellowColor
        expensesLabel?.backgroundColor = Styles.redColor
        incomesLabel?.backgroundColor = Styles.greenColor
        totalLabel?.backgroundColor = Styles.yellowColor
    }
    
    private func setupLayer(borderWidth: CGFloat) {
        layer.cornerRadius = 6
        layer.masksToBounds = true
        layer.borderColor = Styles.darkRedColor.cgColor
        layer.borderWidth = borderWidth
    }

    private func createLabel() -> UILabel {
        let textInset = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4)
        let label = InsetLabel(insets: textInset)
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.adjustsFontSizeToFitWidth = true
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
