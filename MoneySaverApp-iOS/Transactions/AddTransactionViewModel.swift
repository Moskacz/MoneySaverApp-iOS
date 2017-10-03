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

struct AddTransactionFormData {
    let title: String
    let value: NSDecimalNumber
    let creationTimeStamp: TimeInterval
    let category: TransactionCategory
}

enum AddTransactionFormError: Error {
    case missingData
    case invalidValueFormat
}

class AddTransactionViewModel {
    
    private let transactionsModel: TransactionsModel
    private let mapper: Mapper<AddTransactionFormData, [AnyHashable: Any]>
    
    var title: String? = nil
    var category: TransactionCategory? = nil
    var value: String? = nil
    
    init(transactionsModel: TransactionsModel, mapper: Mapper<AddTransactionFormData, [AnyHashable: Any]>) {
        self.transactionsModel = transactionsModel
        self.mapper = mapper
    }
    
    func addTransaction() -> Observable<Void> {
        do {
            let data = try createDataObject()
            transactionsModel.addTransaction(withData: data)
            return Observable.just(())
        } catch {
            return Observable.error(error)
        }
    }
    
    private func createDataObject() throws -> AddTransactionFormData {
        guard let transactionTitle = title,
            let transactionCategory = category,
            let transactionValue = value else {
            throw AddTransactionFormError.missingData
        }
        
        let decimalValue = NSDecimalNumber(string: transactionValue, locale: Locale.current)
        if decimalValue == NSDecimalNumber.notANumber {
            throw AddTransactionFormError.invalidValueFormat
        }
        
        return AddTransactionFormData(title: transactionTitle,
                                      value: decimalValue,
                                      creationTimeStamp: NSDate().timeIntervalSince1970,
                                      category: transactionCategory)
    }
}
