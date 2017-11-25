//
//  BudgetRepository.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 25.11.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation
import CoreData

protocol BudgetRepository {
    func currentBudgetValue() -> Decimal
    func saveBudget(withValue value: Decimal)
}

class BudgetRepositoryImpl: BudgetRepository {
    
    private let context: NSManagedObjectContext
    private let logger: Logger
    
    init(context: NSManagedObjectContext, logger: Logger) {
        self.context = context
        self.logger = logger
    }
    
    func currentBudgetValue() -> Decimal {
        let request = fetchRequest
        request.fetchLimit = 1
        do {
            let budget = try context.fetch(request).first
            return budget?.value as Decimal? ?? 0
        } catch {
            logger.log(withLevel: .error, message: error.localizedDescription)
            return Decimal(0)
        }
    }
    
    func saveBudget(withValue value: Decimal) {
        
    }
    
    private var fetchRequest: NSFetchRequest<BudgetManagedObject> {
        return BudgetManagedObject.fetchRequest()
    }
}
