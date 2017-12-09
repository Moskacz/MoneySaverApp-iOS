//
//  TransactionsSummaryElementViewModel.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 09.12.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation

protocol TransactionsSummaryElementViewModel {
    var title: String? { get }
    var incomes: String? { get }
    var expenses: String? { get }
    var total: String? { get }
}
