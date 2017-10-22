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
    func allEntitiesFRC(completion: @escaping ((NSFetchedResultsController<TransactionCategoryManagedObject>) -> Void))
}

class TransactionCategoryServiceImpl: TransactionCategoryService {
    
    private let repository: TransactionCategoryRepository
    
    init(repository: TransactionCategoryRepository) {
        self.repository = repository
        prefillDataIfNeeded()
    }
    
    func allEntitiesFRC(completion: @escaping ((NSFetchedResultsController<TransactionCategoryManagedObject>) -> Void)) {
        return repository.allEntitiesFRC(completion: completion)
    }
    
    private func prefillDataIfNeeded() {
        repository.countOfEntities { [weak self] (count) in
            guard count == 0 else { return }
            let categories = self?.initialCategories() ?? []
            self?.repository.createEntities(forCategories: categories)
        }
    }
    
    private func initialCategories() -> [TransactionCategory] {
        return [TransactionCategory(identifier: UUID(), name: "Animals", icon: #imageLiteral(resourceName: "animals"), backgroundColor: UIColor.white),
                TransactionCategory(identifier: UUID(), name: "Bills", icon: #imageLiteral(resourceName: "bills"), backgroundColor: UIColor.white),
                TransactionCategory(identifier: UUID(), name: "Car", icon: #imageLiteral(resourceName: "car"), backgroundColor: UIColor.white),
                TransactionCategory(identifier: UUID(), name: "Detergents", icon:#imageLiteral(resourceName: "detergents"), backgroundColor: UIColor.white),
                TransactionCategory(identifier: UUID(), name: "Clothes", icon: #imageLiteral(resourceName: "clothes"), backgroundColor: UIColor.white),
                TransactionCategory(identifier: UUID(), name: "Cosmetics", icon: #imageLiteral(resourceName: "cosmetics"), backgroundColor: UIColor.white),
                TransactionCategory(identifier: UUID(), name: "Educations", icon: #imageLiteral(resourceName: "education"), backgroundColor: UIColor.white),
                TransactionCategory(identifier: UUID(), name: "Homeware", icon: #imageLiteral(resourceName: "homeware"), backgroundColor: UIColor.white),
                TransactionCategory(identifier: UUID(), name: "Groceries", icon: #imageLiteral(resourceName: "groceries"), backgroundColor: UIColor.white),
                TransactionCategory(identifier: UUID(), name: "Health", icon: #imageLiteral(resourceName: "health"), backgroundColor: UIColor.white),]
    }
}
