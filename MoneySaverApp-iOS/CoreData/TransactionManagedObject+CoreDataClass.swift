//
//  TransactionManagedObject+CoreDataClass.swift
//  MoneySaverApp-iOS
//
//  Created by Michał Moskała on 29.03.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation
import CoreData


public class TransactionManagedObject: NSManagedObject {
    
    class var entityName: String {
        return "TransactionManagedObject"
    }
    
    class func createEntity(inContext context: NSManagedObjectContext) -> TransactionManagedObject {
        return NSEntityDescription.insertNewObject(forEntityName: TransactionManagedObject.entityName, into: context) as! TransactionManagedObject
    }
}
