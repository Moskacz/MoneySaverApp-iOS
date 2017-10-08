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
    func createEntity(forCategory category: TransactionCategory)
    func allEntitiesFRC() -> NSFetchedResultsController<TransactionCategoryManagedObject>
}

class TransactionCategoryRepositoryImpl: TransactionCategoryRepository {
    
    private let stack: CoreDataStack
    
    init(stack: CoreDataStack) {
        self.stack = stack
    }
    
    func createEntity(forCategory category: TransactionCategory) {
        stack.performBackgroundTask { (context) in
            let entity = TransactionCategoryManagedObject.createEntity(inContext: context)
            self.updateProperties(ofEntity: entity, withCategory: category)
        }
    }
    
    private func updateProperties(ofEntity entity: TransactionCategoryManagedObject,
                                  withCategory category: TransactionCategory) {
        entity.identifier = category.identifier
        entity.name = category.name
        let rgbColor = RGBAColor(color: category.backgroundColor)
        entity.backgroundColorGreenComponent = Float(rgbColor.red)
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
