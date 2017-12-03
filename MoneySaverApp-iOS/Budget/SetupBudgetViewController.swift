
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
    var closeButtonCallback = {}
    
    @IBOutlet private weak var budgetTextField: UITextField?
    @IBOutlet private weak var confirmButton: UIButton?
    @IBOutlet private weak var closeButton: UIButton?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        closeButton?.isHidden = !isPresented
    }
    
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
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        closeButtonCallback()
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
