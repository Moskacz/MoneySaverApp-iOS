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
            setupDisplayedData(animated: false)
        }
    }
    
    @IBOutlet private weak var expensesLabel: UILabel?
    @IBOutlet private weak var incomesLabel: UILabel?
    @IBOutlet private weak var totalLabel: UILabel?
    @IBOutlet private weak var dateRangeButton: UIButton?
    
    private var gradientView: GradientView {
        return view as! GradientView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gradientView.gradient = Gradients.activeElement
        setupDisplayedData(animated: false)
    }
    
    private func setupDisplayedData(animated: Bool) {
        expensesLabel?.set(text: viewModel?.expensesAmountText, animated: animated)
        incomesLabel?.set(text: viewModel?.incomesAmountText, animated: animated)
        totalLabel?.set(text: viewModel?.totalAmountText, animated: animated)
        dateRangeButton?.setTitle(viewModel?.dateRangeButtonText, for: .normal)
    }
    
    @IBAction func daraRangeButtonTapped(_ sender: UIButton) {
        
    }
}

extension TransactionsSummaryViewController: TransactionsSummaryViewModelDelegate {
    
    func transactionsSummaryDidUpdateValues(viewModel: TransactionsSummaryViewModel) {
        setupDisplayedData(animated: true)
    }
}
