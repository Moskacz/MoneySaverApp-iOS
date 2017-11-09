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
        return [TransactionCategory(identifier: UUID(), name: "Animals", icon: #imageLiteral(resourceName: "animals"), backgroundColor: #colorLiteral(red: 0.6156862745, green: 0.7764705882, blue: 0.8470588235, alpha: 1)),
                TransactionCategory(identifier: UUID(), name: "Bills", icon: #imageLiteral(resourceName: "bills"), backgroundColor: #colorLiteral(red: 0, green: 0.7019607843, blue: 0.7921568627, alpha: 1)),
                TransactionCategory(identifier: UUID(), name: "Car", icon: #imageLiteral(resourceName: "car"), backgroundColor: #colorLiteral(red: 0.4901960784, green: 0.8156862745, blue: 0.7137254902, alpha: 1)),
                TransactionCategory(identifier: UUID(), name: "Detergents", icon:#imageLiteral(resourceName: "detergents"), backgroundColor: #colorLiteral(red: 0.1137254902, green: 0.3058823529, blue: 0.537254902, alpha: 1)),
                TransactionCategory(identifier: UUID(), name: "Clothes", icon: #imageLiteral(resourceName: "clothes"), backgroundColor: #colorLiteral(red: 0.8235294118, green: 0.6980392157, blue: 0.6078431373, alpha: 1)),
                TransactionCategory(identifier: UUID(), name: "Cosmetics", icon: #imageLiteral(resourceName: "cosmetics"), backgroundColor: #colorLiteral(red: 0.8901960784, green: 0.5254901961, blue: 0.5647058824, alpha: 1)),
                TransactionCategory(identifier: UUID(), name: "Educations", icon: #imageLiteral(resourceName: "education"), backgroundColor: #colorLiteral(red: 0.9647058824, green: 0.5725490196, blue: 0.337254902, alpha: 1)),
                TransactionCategory(identifier: UUID(), name: "Homeware", icon: #imageLiteral(resourceName: "homeware"), backgroundColor: #colorLiteral(red: 0.9176470588, green: 0.8509803922, blue: 0.5450980392, alpha: 1)),
                TransactionCategory(identifier: UUID(), name: "Groceries", icon: #imageLiteral(resourceName: "groceries"), backgroundColor: #colorLiteral(red: 0.5882352941, green: 0.3215686275, blue: 0.3176470588, alpha: 1)),
                TransactionCategory(identifier: UUID(), name: "Health", icon: #imageLiteral(resourceName: "health"), backgroundColor: #colorLiteral(red: 0.7764705882, green: 0.8, blue: 0.8, alpha: 1))]
    }
}
