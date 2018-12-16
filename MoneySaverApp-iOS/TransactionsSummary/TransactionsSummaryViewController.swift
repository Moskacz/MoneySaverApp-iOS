//
//  TransactionsSummaryViewController.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 22.03.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import UIKit
import MoneySaverAppCore
import MMFoundation

class TransactionsSummaryViewController: UIViewController {
    
    var presenter: TransactionsSummaryPresenterProtocol!
    
    @IBOutlet private weak var expensesLabel: UILabel?
    @IBOutlet private weak var incomesLabel: UILabel?
    @IBOutlet private weak var totalLabel: UILabel?
    @IBOutlet private weak var dateRangeButton: UIButton?
    
    private var gradientView: GradientView {
        return view as! GradientView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
        presenter.start()
    }
    
    private func setupAppearance() {
        gradientView.update(with: AppGradient.summaryView.value)
        dateRangeButton?.backgroundColor = AppColor.activeElement.value
    }
    
    @IBAction func dataRangeButtonTapped(_ sender: UIButton) {
        presenter!.dateRangeButtonTapped()
    }
}

extension TransactionsSummaryViewController: TransactionsSummaryUI {
    
    func set(incomesText: String?) {
        incomesLabel?.text = incomesText
    }
    
    func set(expenseText: String?) {
        expensesLabel?.text = expenseText
    }
    
    func set(totalAmountString: String?) {
        totalLabel?.text = totalAmountString
    }
    
    func set(dateRangeTitle: String?) {
        dateRangeButton?.setTitle(dateRangeTitle, for: .normal)
    }
}
