//
//  AddTransactionViewModel.swift
//  MoneySaverApp-iOS
//
//  Created by Michał Moskała on 08.04.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation
import MoneySaverFoundationiOS

enum TransactionDataFormError: Error {
    case missingTitle
    case missingValue
    case invalidValue
    
}

class TransactionDataViewModel {
    
    var transactionTitle: String? = nil
    var transactionValue: String? = nil
    
    func data() throws -> TransactionData {
        guard let title = transactionTitle, !title.isEmpty else {
            throw TransactionDataFormError.missingTitle
        }
        guard let value = transactionValue else {
            throw TransactionDataFormError.missingValue
        }
        guard let decimalValue = Decimal(string: value) else {
            throw TransactionDataFormError.invalidValue
        }
        
        return TransactionData(title: title, value: decimalValue)
    }
}
