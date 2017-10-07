//
//  TransactionCategoryManagedObject+CoreDataProperties.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 07.10.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//
//

import Foundation
import CoreData


extension TransactionCategoryManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TransactionCategoryManagedObject> {
        return NSFetchRequest<TransactionCategoryManagedObject>(entityName: "TransactionCategoryManagedObject")
    }

    @NSManaged public var backgroundColorAlphaComponent: Float
    @NSManaged public var backgroundColorBlueComponent: Float
    @NSManaged public var backgroundColorGreenComponent: Float
    @NSManaged public var backgroundColorRedComponent: Float
    @NSManaged public var icon: NSData?
    @NSManaged public var identifier: UUID?
    @NSManaged public var name: String?
    @NSManaged public var transactions: TransactionManagedObject?

}
