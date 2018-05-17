//
//  TransactionTypePickerView.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 17.05.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import UIKit

enum TransactionType {
    case income
    case expense
}

protocol TransactionTypePickerViewDelegate: class {
    func transactionType(picker: TransactionTypePickerView, didSelect type: TransactionType)
}

final class TransactionTypePickerView: UIView {
    
    weak var delegate: TransactionTypePickerViewDelegate?
    @IBOutlet private weak var incomeContainer: UIView?
    @IBOutlet private weak var expenseContainer: UIView?
    
    private let availableTypes = [TransactionType.income, TransactionType.expense]
    
    static func makeView() -> TransactionTypePickerView {
        let views = Bundle.main.loadNibNamed("TransactionTypePickerView", owner: nil, options: nil)
        let view = views?[0] as! TransactionTypePickerView
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupAppearance()
    }
    
    private func setupAppearance() {
        incomeContainer?.backgroundColor = AppColor.green.value
        expenseContainer?.backgroundColor = AppColor.red.value
    }
    
    // MARK: UIAction
    @IBAction func incomeTypeTapped(_ sender: UITapGestureRecognizer) {
        delegate?.transactionType(picker: self, didSelect: .income)
    }
    
    @IBAction func expenseTapped(_ sender: UITapGestureRecognizer) {
        delegate?.transactionType(picker: self, didSelect: .expense)
    }
}
