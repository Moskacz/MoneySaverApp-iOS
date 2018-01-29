//
//  BudgetManagedObject+CoreDataProperties.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 29.01.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
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
