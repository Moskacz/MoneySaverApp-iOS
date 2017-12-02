//
//  BudgetService.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 02.12.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation
import CoreData

protocol BudgetService {
    func budgetFRC() -> NSFetchedResultsController<BudgetManagedObject>
}

class BudgetServiceImpl: BudgetService {
    
    private let repository: BudgetRepository
    
    init(repository: BudgetRepository) {
        self.repository = repository
    }
    
    func budgetFRC() -> NSFetchedResultsController<BudgetManagedObject> {
        let request = repository.fetchRequest
        request.sortDescriptors = [repository.sortDescriptor]
        
        return NSFetchedResultsController(fetchRequest: request,
                                          managedObjectContext: repository.context,
                                          sectionNameKeyPath: nil,
                                          cacheName: nil)
    }
}
