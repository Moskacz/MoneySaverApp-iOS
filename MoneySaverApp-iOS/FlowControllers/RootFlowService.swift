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
    var preferredDateRange: DateRange { get set }
}

class RootFlowServiceImpl: RootFlowService {
    
    private let repository: TransactionsRepository
    private let userPreferences: UserPreferences
    
    init(repository: TransactionsRepository, userPreferences: UserPreferences) {
        self.repository = repository
        self.userPreferences = userPreferences
    }
    
    func addTransaction(withData data: TransactionData, category: TransactionCategoryManagedObject) {
        repository.addTransaction(data: data, category: category)
    }
    
    var preferredDateRange: DateRange {
        get { return userPreferences.dateRange }
        set { userPreferences.dateRange = newValue }
    }
    
}
