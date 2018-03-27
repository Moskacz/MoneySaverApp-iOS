//
//  TransactionCategoryService.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 12.10.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation
import CoreData

protocol TransactionCategoryService {
    func allEntitiesFRC() -> NSFetchedResultsController<TransactionCategoryManagedObject>
}

class TransactionCategoryServiceImpl: TransactionCategoryService {
    
    private let repository: TransactionCategoryRepository
    
    init(repository: TransactionCategoryRepository) {
        self.repository = repository
        prefillDataIfNeeded()
    }
    
    func allEntitiesFRC() -> NSFetchedResultsController<TransactionCategoryManagedObject> {
        return repository.allEntitiesFRC()
    }
    
    private func prefillDataIfNeeded() {
        guard repository.countOfEntities() == 0 else {
            return
        }
        repository.createInitialCategories()
    }
    
}
