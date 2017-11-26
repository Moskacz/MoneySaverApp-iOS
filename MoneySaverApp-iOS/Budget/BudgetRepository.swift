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
    func currentBudgetValue() -> Decimal?
    func saveBudget(withValue value: Decimal)
}

class BudgetRepositoryImpl: BudgetRepository {
    
    private let context: NSManagedObjectContext
    private let logger: Logger
    
    init(context: NSManagedObjectContext, logger: Logger) {
        self.context = context
        self.logger = logger
    }
    
    func currentBudgetValue() -> Decimal? {
        let request = fetchRequest
        request.fetchLimit = 1
        do {
            let budget = try context.fetch(request).first
            return budget?.value as Decimal?
        } catch {
            logger.log(withLevel: .error, message: error.localizedDescription)
            return nil
        }
    }
    
    func saveBudget(withValue value: Decimal) {
        let request = fetchRequest
        do {
            let entities = try context.fetch(request)
            if entities.isEmpty {
                createNewBudget(value: value)
            } else {
                updateBudget(value: value, entities: entities)
            }
            try context.save()
        } catch {
            logger.log(withLevel: .error, message: error.localizedDescription)
        }
    }
    
    private func createNewBudget(value: Decimal) {
        let entity = BudgetManagedObject.createEntity(inContext: context)
        entity.value = value as NSDecimalNumber
    }
    
    private func updateBudget(value: Decimal, entities: [BudgetManagedObject]) {
        if entities.count > 1 {
            for entity in entities.dropFirst() {
                context.delete(entity)
            }
        } else {
            let entity = entities[0]
            entity.value = value as NSDecimalNumber
        }
    }
    
    private var fetchRequest: NSFetchRequest<BudgetManagedObject> {
        return BudgetManagedObject.fetchRequest()
    }
}
