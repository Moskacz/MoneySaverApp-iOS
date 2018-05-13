//
//  TransactionsSummaryViewController.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 22.03.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import UIKit
import MMFoundation

class TransactionsSummaryViewController: UIViewController {
    
    var viewModel: TransactionsSummaryViewModel?
    var didTapOnDateRangeButton: (UIButton) -> Void = { _ in }
    
    @IBOutlet private weak var expensesLabel: UILabel?
    @IBOutlet private weak var incomesLabel: UILabel?
    @IBOutlet private weak var totalLabel: UILabel?
    @IBOutlet private weak var dateRangeButton: GradientButton?
    
    private var gradientView: GradientView {
        return view as! GradientView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.delegate = self
        setupAppearance()
        setupDisplayedData(animated: false)
    }
    
    private func setupAppearance() {
        gradientView.update(with: AppGradient.summaryView.value)
        dateRangeButton?.update(with: AppGradient.activeElement.value)
        dateRangeButton?.addBottomShadow()
    }
    
    private func setupDisplayedData(animated: Bool) {
        expensesLabel?.set(text: viewModel?.expensesAmountText, animated: animated)
        incomesLabel?.set(text: viewModel?.incomesAmountText, animated: animated)
        totalLabel?.set(text: viewModel?.totalAmountText, animated: animated)
        dateRangeButton?.setTitle(viewModel?.dateRangeButtonText, for: .normal)
    }
    
    @IBAction func dataRangeButtonTapped(_ sender: UIButton) {
        didTapOnDateRangeButton(sender)
    }
}

extension TransactionsSummaryViewController: TransactionsSummaryViewModelDelegate {
    
    func transactionsSummaryDidUpdateValues(viewModel: TransactionsSummaryViewModel) {
        setupDisplayedData(animated: true)
    }
}
