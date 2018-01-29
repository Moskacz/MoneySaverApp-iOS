//
//  CalendarDate+CoreDataClass.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 29.01.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//
//

import Foundation
import CoreData


public class CalendarDate: NSManagedObject {
    
    enum AttributeNames: String {
        case calendarIdentifier
        case dayOfEra
        case dayOfMonth
        case dayOfWeek
        case dayOfYear
        case era
        case weekOfEra
        case weekOfMonth
        case weekOfYear
        case year
        case timeInterval
    }
    
    enum Relationships: String {
        case transaction
    }

}
