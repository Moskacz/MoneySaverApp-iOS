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
    func createEntities(forCategories categories: [TransactionCategory])
    func allEntitiesFRC() -> NSFetchedResultsController<TransactionCategoryManagedObject>
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
    
    func createEntities(forCategories categories: [TransactionCategory]) {
        context.perform {
            for category in categories {
                let entity = TransactionCategoryManagedObject.createEntity(inContext: self.context)
                self.updateProperties(ofEntity: entity, withCategory: category)
            }
            
            if self.context.hasChanges {
                do {
                    try self.context.save()
                } catch {
                    self.logger.log(withLevel: .error, message: error.localizedDescription)
                }
            }
        }
    }
    
    private func updateProperties(ofEntity entity: TransactionCategoryManagedObject,
                                  withCategory category: TransactionCategory) {
        entity.name = category.name
        entity.icon = UIImagePNGRepresentation(category.icon) as NSData?
        entity.color = category.backgroundColor.encode() as NSData
    }
    
    func allEntitiesFRC() -> NSFetchedResultsController<TransactionCategoryManagedObject> {
        let fetchRequest: NSFetchRequest<TransactionCategoryManagedObject> = TransactionCategoryManagedObject.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: TransactionCategoryManagedObject.nameAttributeName, ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        return NSFetchedResultsController(fetchRequest: fetchRequest,
                                          managedObjectContext: context,
                                          sectionNameKeyPath: nil,
                                          cacheName: nil)
    }
}
