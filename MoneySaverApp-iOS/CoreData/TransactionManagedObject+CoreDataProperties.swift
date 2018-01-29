//
//  TransactionManagedObject+CoreDataProperties.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 29.01.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//
//

import Foundation
import CoreData

extension TransactionManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TransactionManagedObject> {
        return NSFetchRequest<TransactionManagedObject>(entityName: "TransactionManagedObject")
    }

    @NSManaged public var title: String?
    @NSManaged public var value: NSDecimalNumber?
    @NSManaged public var category: TransactionCategoryManagedObject?
    @NSManaged public var date: CalendarDate?

}
