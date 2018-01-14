//
//  TransactionManagedObject+CoreDataProperties.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 14.01.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//
//

import Foundation
import CoreData


extension TransactionManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TransactionManagedObject> {
        return NSFetchRequest<TransactionManagedObject>(entityName: "TransactionManagedObject")
    }

    @NSManaged public var creationTimeInterval: Double
    @NSManaged public var dayOfEra: Int32
    @NSManaged public var dayOfMonth: Int32
    @NSManaged public var dayOfWeek: Int32
    @NSManaged public var dayOfYear: Int32
    @NSManaged public var monthOfYear: Int32
    @NSManaged public var title: String?
    @NSManaged public var value: NSDecimalNumber?
    @NSManaged public var weekOfYear: Int32
    @NSManaged public var year: Int32
    @NSManaged public var monthOfEra: Int32
    @NSManaged public var weekOfMonth: Int32
    @NSManaged public var weekOfEra: Int32
    @NSManaged public var category: TransactionCategoryManagedObject?

}
