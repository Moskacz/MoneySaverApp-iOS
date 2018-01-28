//
//  CalendarDay+CoreDataProperties.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 28.01.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//
//

import Foundation
import CoreData

extension CalendarDay {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CalendarDay> {
        return NSFetchRequest<CalendarDay>(entityName: "CalendarDay")
    }

    @NSManaged public var calendarIdentifier: String?
    @NSManaged public var dayOfWeek: Int32
    @NSManaged public var dayOfMonth: Int32
    @NSManaged public var dayOfYear: Int32
    @NSManaged public var dayOfEra: Int32
    @NSManaged public var weekOfMonth: Int32
    @NSManaged public var weekOfYear: Int32
    @NSManaged public var weekOfEra: Int32
    @NSManaged public var year: Int32
    @NSManaged public var era: Int32

}
