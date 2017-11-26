
//
//  File.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 25.11.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import UIKit

class SetupBudgetViewController: UIViewController {
    
    var viewModel: SetupBudgetViewModel?
    var budgetSetCallback = {}
    
    @IBOutlet private weak var budgetTextField: UITextField?
    @IBOutlet private weak var confirmButton: UIButton?
    
    // MARK: UI Actions
    
    @IBAction func confirmButtonTapped(_ sender: UIButton) {
        guard let model = viewModel else { return }
        do {
            passDataToViewModel()
            try model.saveBudget()
            budgetSetCallback()
        } catch {
            handle(error: error)
        }
    }
    
    private func passDataToViewModel() {
        viewModel?.providedBudgetAmount = budgetTextField?.text
    }
    
    private func handle(error: Error) {
        guard let formError = error as? SetupBudgetError else { return }
        switch formError {
        case .incorrectAmount:
            budgetTextField?.displayAsIncorrect()
        }
    }

}
