
//
//  File.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 25.11.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import UIKit

class SetupBudgetViewController: UIViewController {
    
    var budgetSetCallback = {}
    
    @IBOutlet private weak var budgetTextField: UITextField?
    @IBOutlet private weak var confirmButton: UIButton?
    
    // MARK: UI Actions
    
    @IBAction func confirmButtonTapped(_ sender: UIButton) {
        budgetSetCallback()
    }

}
