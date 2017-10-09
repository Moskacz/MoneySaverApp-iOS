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
    case missingData
    case invalidValueFormat
}

class TransactionDataViewModel {
    
    private let transactionsModel: TransactionsModel
    
    init(transactionsModel: TransactionsModel) {
        self.transactionsModel = transactionsModel
    }
}
