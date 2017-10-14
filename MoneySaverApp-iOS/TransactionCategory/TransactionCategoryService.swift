//
//  TransactionCategoryService.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 12.10.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation
import MoneySaverFoundationiOS
import CoreData

protocol TransactionCategoryService {
    var allEntitiesFRC: NSFetchedResultsController<TransactionCategoryManagedObject> { get }
}

class TransactionCategoryServiceImpl: TransactionCategoryService {
    
    private let repository: TransactionCategoryRepository
    
    init(repository: TransactionCategoryRepository) {
        self.repository = repository
        prefillDataIfNeeded()
    }
    
    lazy var allEntitiesFRC: NSFetchedResultsController<TransactionCategoryManagedObject> = {
        return self.repository.allEntitiesFRC()
    }()
    
    private func prefillDataIfNeeded() {
        guard repository.countOfEntities() == 0 else { return }
        repository.createEntities(forCategories: initialCategories())
    }
    
    private func initialCategories() -> [TransactionCategory] {
        return [TransactionCategory(identifier: UUID(), name: "Test", icon: UIImage(), backgroundColor: UIColor.green)]
    }
}
