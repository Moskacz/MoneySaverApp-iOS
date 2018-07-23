//
//  SetupBudgetViewModel.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 25.11.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation
import MoneySaverAppCore

enum SetupBudgetError: Error {
    case incorrectAmount
}

class SetupBudgetViewModel {
    
    var providedBudgetAmount: String? = nil
    
    func saveBudget() throws {
        guard
            let amountString = providedBudgetAmount,
            let amount = Decimal(string: amountString),
            amount > 0,
            !amount.isNaN
             else {
            throw SetupBudgetError.incorrectAmount
        }
        
//        budgetRepository.saveBudget(withValue: amount)
    }
}
