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
    
    private let stack: CoreDataStack
    private let logger: Logger
    
    init(stack: CoreDataStack, logger: Logger) {
        self.stack = stack
        self.logger = logger
    }
    
    func countOfEntities() -> Int {
        let fetchRequest: NSFetchRequest<TransactionCategoryManagedObject> = TransactionCategoryManagedObject.fetchRequest()
        do {
            return try stack.getViewContext().count(for: fetchRequest)
        } catch {
            logger.log(withLevel: .error, message: error.localizedDescription)
            return 0
        }
    }
    
    func createEntities(forCategories categories: [TransactionCategory]) {
        stack.performBackgroundTask { (context) in
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
    
    private func updateProperties(ofEntity entity: TransactionCategoryManagedObject,
                                  withCategory category: TransactionCategory) {
        entity.identifier = category.identifier
        entity.name = category.name
        let rgbColor = RGBAColor(color: category.backgroundColor)
        entity.backgroundColorRedComponent = Float(rgbColor.red)
        entity.backgroundColorGreenComponent = Float(rgbColor.green)
        entity.backgroundColorBlueComponent = Float(rgbColor.blue)
        entity.backgroundColorAlphaComponent = Float(rgbColor.alpha)
        entity.icon = UIImagePNGRepresentation(category.icon) as NSData?
    }
    
    func allEntitiesFRC() -> NSFetchedResultsController<TransactionCategoryManagedObject> {
        let fetchRequest: NSFetchRequest<TransactionCategoryManagedObject> = TransactionCategoryManagedObject.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: TransactionCategoryManagedObject.nameAttributeName, ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        return NSFetchedResultsController(fetchRequest: fetchRequest,
                                          managedObjectContext: stack.getViewContext(),
                                          sectionNameKeyPath: nil,
                                          cacheName: nil)
    }
    
}
