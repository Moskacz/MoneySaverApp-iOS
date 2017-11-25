//
//  BudgetManagedObject+CoreDataProperties.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 25.11.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//
//

import Foundation
import CoreData


extension BudgetManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BudgetManagedObject> {
        return NSFetchRequest<BudgetManagedObject>(entityName: "BudgetManagedObject")
    }

    @NSManaged public var value: NSDecimalNumber?

}
