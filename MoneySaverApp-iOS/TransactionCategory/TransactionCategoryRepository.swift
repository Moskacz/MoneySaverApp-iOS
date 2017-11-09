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
    func countOfEntities(completion: @escaping ((Int) -> Void))
    func createEntities(forCategories categories: [TransactionCategory])
    func allEntitiesFRC(completion: @escaping ((NSFetchedResultsController<TransactionCategoryManagedObject>) -> Void))
}

class TransactionCategoryRepositoryImpl: TransactionCategoryRepository {
    
    private let stack: CoreDataStack
    private let logger: Logger
    
    init(stack: CoreDataStack, logger: Logger) {
        self.stack = stack
        self.logger = logger
    }
    
    func countOfEntities(completion: @escaping ((Int) -> Void)) {
        stack.getViewContext { (context) in
            let fetchRequest: NSFetchRequest<TransactionCategoryManagedObject> = TransactionCategoryManagedObject.fetchRequest()
            do {
                let count = try context.count(for: fetchRequest)
                completion(count)
            } catch {
                self.logger.log(withLevel: .error, message: error.localizedDescription)
                return completion(0)
            }
        }
    }
    
    func createEntities(forCategories categories: [TransactionCategory]) {
        stack.getViewContext { (context) in
            context.perform {
                for category in categories {
                    let entity = TransactionCategoryManagedObject.createEntity(inContext: context)
                    self.updateProperties(ofEntity: entity, withCategory: category)
                }
                
                if context.hasChanges {
                    do {
                        try context.save()
                    } catch {
                        self.logger.log(withLevel: .error, message: error.localizedDescription)
                    }
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
    
    func allEntitiesFRC(completion: @escaping ((NSFetchedResultsController<TransactionCategoryManagedObject>) -> Void)) {
        return stack.getViewContext(completion: { (context) in
            let fetchRequest: NSFetchRequest<TransactionCategoryManagedObject> = TransactionCategoryManagedObject.fetchRequest()
            let sortDescriptor = NSSortDescriptor(key: TransactionCategoryManagedObject.nameAttributeName, ascending: true)
            fetchRequest.sortDescriptors = [sortDescriptor]
            let frc = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                 managedObjectContext: context,
                                                 sectionNameKeyPath: nil,
                                                 cacheName: nil)
            completion(frc)
        })
    }
}
