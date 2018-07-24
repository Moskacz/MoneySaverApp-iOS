//
//  RootFlowService.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 14.01.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import Foundation
import MoneySaverAppCore

protocol RootFlowService {
    func addTransaction(withData data: TransactionData, category: TransactionCategoryManagedObject)
    var preferredDateRange: DateRange { get set }
}

class RootFlowServiceImpl: RootFlowService {
    
    private let userPreferences: UserPreferences
    
    init(userPreferences: UserPreferences) {
        self.userPreferences = userPreferences
    }
    
    func addTransaction(withData data: TransactionData, category: TransactionCategoryManagedObject) {
    }
    
    var preferredDateRange: DateRange {
        get { return userPreferences.dateRange }
        set { userPreferences.dateRange = newValue }
    }
}
