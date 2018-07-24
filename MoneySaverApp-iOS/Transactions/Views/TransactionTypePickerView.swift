//
//  TransactionTypePickerView.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 17.05.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import UIKit
import MoneySaverAppCore

enum TransactionType {
    case income
    case expense
}

protocol TransactionTypePickerViewDelegate: class {
    func transactionType(picker: TransactionTypePickerView, didSelect type: TransactionType)
}

final class TransactionTypePickerView: UIView {
    
    static func makeView() -> TransactionTypePickerView {
        let views = Bundle.main.loadNibNamed("TransactionTypePickerView", owner: nil, options: nil)
        let view = views?[0] as! TransactionTypePickerView
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    weak var delegate: TransactionTypePickerViewDelegate?
    @IBOutlet weak var incomeButton: UIButton?
    @IBOutlet weak var expenseButton: UIButton?
    
    var selectedType: TransactionType? {
        didSet {
            incomeButton?.alpha = 0.3
            expenseButton?.alpha = 0.3
            guard let type = selectedType else { return }
            switch type {
            case .income: incomeButton?.alpha = 1.0
            case .expense: expenseButton?.alpha = 1.0
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupAppearance()
    }
    
    private func setupAppearance() {
        incomeButton?.backgroundColor = AppColor.green.value
        expenseButton?.backgroundColor = AppColor.red.value
    }
    
    // MARK: UIAction
    
    @IBAction func incomeButtonTapped(_ sender: UIButton) {
        selectedType = .income
        delegate?.transactionType(picker: self, didSelect: .income)
    }
    
    @IBAction func expenseButtonTapped(_ sender: UIButton) {
        selectedType = .expense
        delegate?.transactionType(picker: self, didSelect: .expense)
    }
}
