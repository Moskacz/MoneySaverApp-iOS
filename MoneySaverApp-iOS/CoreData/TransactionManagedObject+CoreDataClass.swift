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
    
    static let entityName = "TransactionManagedObject"
    
    class func insertNew(inContext context: NSManagedObjectContext) -> TransactionManagedObject {
        return NSEntityDescription.insertNewObject(forEntityName: entityName, into: context) as! TransactionManagedObject
    }
    
}
