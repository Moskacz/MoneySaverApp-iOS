//
//  TransactionManagedObject+CoreDataProperties.swift
//  MoneySaverApp-iOS
//
//  Created by Michał Moskała on 29.03.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation
import CoreData


extension TransactionManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TransactionManagedObject> {
        return NSFetchRequest<TransactionManagedObject>(entityName: "TransactionManagedObject");
    }

    @NSManaged public var value: NSDecimalNumber?
    @NSManaged public var category: String?
    @NSManaged public var title: String?

}
