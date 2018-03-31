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
    
    var viewModel: TransactionsSummaryViewModel? {
        didSet {
            viewModel?.delegate = self
            guard isViewLoaded else { return }
            setupDisplayedData()
        }
    }
    
    @IBOutlet private weak var expensesLabel: UILabel?
    @IBOutlet private weak var incomesLabel: UILabel?
    @IBOutlet private weak var totalLabel: UILabel?
    
    private var gradientView: GradientView {
        return view as! GradientView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gradientView.gradient = Gradients.activeElement
        setupDisplayedData()
    }
    
    private func setupDisplayedData() {
        expensesLabel?.text = viewModel?.expensesAmountText
        incomesLabel?.text = viewModel?.incomesAmountText
        totalLabel?.text = viewModel?.totalAmountText
    }
}

extension TransactionsSummaryViewController: TransactionsSummaryViewModelDelegate {
    
    func transactionsSummaryDidUpdateValues(viewModel: TransactionsSummaryViewModel) {
        setupDisplayedData()
    }
}
