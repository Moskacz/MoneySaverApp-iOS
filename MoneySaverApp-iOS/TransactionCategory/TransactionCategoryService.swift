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
        return [TransactionCategory(identifier: UUID(), name: "Animals", icon: #imageLiteral(resourceName: "animals"), backgroundColor: UIColor.white),
                TransactionCategory(identifier: UUID(), name: "Bills", icon: #imageLiteral(resourceName: "bills"), backgroundColor: UIColor.white),
                TransactionCategory(identifier: UUID(), name: "Car", icon: #imageLiteral(resourceName: "car"), backgroundColor: UIColor.white),
                TransactionCategory(identifier: UUID(), name: "Chemistry", icon:#imageLiteral(resourceName: "chemistry"), backgroundColor: UIColor.white),
                TransactionCategory(identifier: UUID(), name: "Clothes", icon: #imageLiteral(resourceName: "clothes"), backgroundColor: UIColor.white),
                TransactionCategory(identifier: UUID(), name: "Cosmetics", icon: #imageLiteral(resourceName: "cosmetics"), backgroundColor: UIColor.white),
                TransactionCategory(identifier: UUID(), name: "Educations", icon: #imageLiteral(resourceName: "education"), backgroundColor: UIColor.white),
                TransactionCategory(identifier: UUID(), name: "Equipment", icon: #imageLiteral(resourceName: "equipment"), backgroundColor: UIColor.white),
                TransactionCategory(identifier: UUID(), name: "Groceries", icon: #imageLiteral(resourceName: "groceries"), backgroundColor: UIColor.white),
                TransactionCategory(identifier: UUID(), name: "Health", icon: #imageLiteral(resourceName: "health"), backgroundColor: UIColor.white),]
    }
}
