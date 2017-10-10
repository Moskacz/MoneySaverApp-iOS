//
//  AddTransactionViewModel.swift
//  MoneySaverApp-iOS
//
//  Created by Michał Moskała on 08.04.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation
import MoneySaverFoundationiOS
import RxSwift

enum TransactionDataFormError: Error {
    case missingTitle
    case missingValue
    case invalidValue
    
}

class TransactionDataViewModel {
    
    private let transactionsModel: TransactionsModel
    
    var transactionTitle: String? = nil
    var transactionValue: String? = nil
    
    init(transactionsModel: TransactionsModel) {
        self.transactionsModel = transactionsModel
    }
    
    func data() throws -> TransactionData {
        guard let title = transactionValue else {
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
