//
//  TransactionCategoryManagedObject+CoreDataProperties.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 21.10.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//
//

import Foundation
import CoreData


extension TransactionCategoryManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TransactionCategoryManagedObject> {
        return NSFetchRequest<TransactionCategoryManagedObject>(entityName: "TransactionCategoryManagedObject")
    }

    @NSManaged public var icon: NSData?
    @NSManaged public var name: String?
    @NSManaged public var transactions: TransactionManagedObject?

}
