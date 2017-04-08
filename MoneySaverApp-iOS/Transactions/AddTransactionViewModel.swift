//
//  AddTransactionViewModel.swift
//  MoneySaverApp-iOS
//
//  Created by Michał Moskała on 08.04.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation
import RxSwift

struct AddTransactionFormData {
    let title: String?
    let category: String?
    let value: String?
}

enum AddTransactionFormError: Error {
    case missingData
    case invalidValueFormat
}

class AddTransactionViewModel {
    
    func addTransaction(withData data: AddTransactionFormData) -> Observable<Void> {
        do {
            try validate(data: data)
            return Observable.empty()
        } catch {
            return Observable.error(error)
        }
    }
    
    private func validate(data: AddTransactionFormData) throws {
        guard data.title != nil, data.category != nil, let value = data.value else {
            throw AddTransactionFormError.missingData
        }
        
        let decimalValue = NSDecimalNumber(string: value, locale: Locale.current)
        if decimalValue == NSDecimalNumber.notANumber {
            throw AddTransactionFormError.invalidValueFormat
        }
    }
}
