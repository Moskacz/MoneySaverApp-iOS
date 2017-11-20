//
//  TransactionManagedObject+CoreDataProperties.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 20.11.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//
//

import Foundation
import CoreData


extension TransactionManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TransactionManagedObject> {
        return NSFetchRequest<TransactionManagedObject>(entityName: "TransactionManagedObject")
    }

    @NSManaged public var creationTimeInterval: Double
    @NSManaged public var title: String?
    @NSManaged public var value: NSDecimalNumber?
    @NSManaged public var dayOfYear: Int64
    @NSManaged public var weekOfYear: Int64
    @NSManaged public var month: Int64
    @NSManaged public var year: Int64
    @NSManaged public var day: Int64
    @NSManaged public var category: TransactionCategoryManagedObject?

}
