//
//  NSManagedObject+Additions.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 03.10.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObject {
    
    class var entityName: String {
        return String(describing: self)
    }
    
    class func createEntity(inContext context: NSManagedObjectContext) -> Self {
        return createEntityHelper(inContext: context)
    }
    
    private class func createEntityHelper<T>(inContext context: NSManagedObjectContext) -> T {
        return NSEntityDescription.insertNewObject(forEntityName: entityName, into: context) as! T
    }
    
}
