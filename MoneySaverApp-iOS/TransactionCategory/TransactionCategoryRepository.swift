//
//  TransactionCategoryService.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 07.10.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation
import CoreData
import MoneySaverFoundationiOS

protocol TransactionCategoryRepository {
    func countOfEntities() -> Int
    func allEntitiesFRC() -> NSFetchedResultsController<TransactionCategoryManagedObject>
    func createInitialCategories()
}

class TransactionCategoryRepositoryImpl: TransactionCategoryRepository {
    
    private let context: NSManagedObjectContext
    private let logger: Logger
    
    init(context: NSManagedObjectContext, logger: Logger) {
        self.context = context
        self.logger = logger
    }
    
    func countOfEntities() -> Int {
        let fetchRequest: NSFetchRequest<TransactionCategoryManagedObject> = TransactionCategoryManagedObject.fetchRequest()
        do {
            return try context.count(for: fetchRequest)
        } catch {
            logger.log(withLevel: .error, message: error.localizedDescription)
            return 0
        }
    }
    
    func allEntitiesFRC() -> NSFetchedResultsController<TransactionCategoryManagedObject> {
        let fetchRequest: NSFetchRequest<TransactionCategoryManagedObject> = TransactionCategoryManagedObject.fetchRequest()
        fetchRequest.sortDescriptors = [TransactionCategoryManagedObject.SortDescriptors.name.descriptor]
        return NSFetchedResultsController(fetchRequest: fetchRequest,
                                          managedObjectContext: context,
                                          sectionNameKeyPath: nil,
                                          cacheName: nil)
    }
    
    func createInitialCategories() {
        context.perform {
            for categoryData in self.initialCategoriesData {
                let entity = TransactionCategoryManagedObject.createEntity(inContext: self.context)
                entity.icon = UIImagePNGRepresentation(categoryData.image) as NSData?
                entity.name = categoryData.name
            }
        }
    }
    
    private var initialCategoriesData: [(name: String, image: UIImage)] {
        return [("Groceries", #imageLiteral(resourceName: "groceries")), ("Gifts", #imageLiteral(resourceName: "gift")), ("Parties", #imageLiteral(resourceName: "party")),
                ("Travels", #imageLiteral(resourceName: "travel")),  ("Car", #imageLiteral(resourceName: "car")),  ("Bills", #imageLiteral(resourceName: "bill")),
                ("Education", #imageLiteral(resourceName: "education")), ("Health", #imageLiteral(resourceName: "health")), ("Clothes", #imageLiteral(resourceName: "clothes")),
                ("Homeware", #imageLiteral(resourceName: "homeware")), ("Cosmetics", #imageLiteral(resourceName: "cosmetics"))]
    }
}
