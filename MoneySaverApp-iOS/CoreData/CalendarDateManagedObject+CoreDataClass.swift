//
//  CalendarDateManagedObject+CoreDataClass.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 14.04.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//
//

import Foundation
import CoreData


public class CalendarDateManagedObject: NSManagedObject {

    func update(with date: CalendarDate) {
        calendarIdentifier = date.calendarIdentifier
        dayOfEra = date.dayOfEra
        dayOfMonth = date.dayOfMonth
        dayOfYear = date.dayOfYear
        era = date.era
        weekOfEra = date.weekOfEra
        weekOfMonth = date.weekOfMonth
        weekOfYear = date.weekOfYear
        year = date.year
        timeInterval = date.timeInterval
        monthOfYear = date.monthOfYear
        monthOfEra = date.monthOfEra
    }
}

extension CalendarDateManagedObject: CalendarDateProtocol {}
