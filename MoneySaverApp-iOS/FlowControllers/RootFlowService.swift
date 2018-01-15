//
//  RootFlowService.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 14.01.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import Foundation

protocol RootFlowService {
    func addTransaction(withData data: TransactionData, category: TransactionCategoryManagedObject)
}
