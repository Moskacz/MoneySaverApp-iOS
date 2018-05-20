//
//  AddTransactionViewModel.swift
//  MoneySaverApp-iOS
//
//  Created by Michał Moskała on 08.04.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation
import MoneySaverAppCore

enum TransactionDataFormError: Error {
    case missingTitle
    case missingValue
    case invalidValue
}

class TransactionDataViewModel {
    
    private var dateFormatter: DateFormatter
    
    var transactionTitle: String? = nil
    var transactionValue: String? = nil
    var transactionDate = Date()
    
    init(dateFormatter: DateFormatter = DateFormatters.formatter(forType: .dateWithTime)) {
        self.dateFormatter = dateFormatter
    }
    
    func data() throws -> TransactionData {
        guard let title = transactionTitle, !title.isEmpty else {
            throw TransactionDataFormError.missingTitle
        }
        guard let value = transactionValue else {
            throw TransactionDataFormError.missingValue
        }
        guard let decimalValue = Decimal(string: value), !decimalValue.isNaN, !decimalValue.isZero else {
            throw TransactionDataFormError.invalidValue
        }
        
        return TransactionData(title: title,
                               value: decimalValue,
                               creationDate: transactionDate)
    }
    
    // MARK: Transaction date
    
    func formatted(date: Date) -> String {
        return dateFormatter.string(from: date)
    }
}
