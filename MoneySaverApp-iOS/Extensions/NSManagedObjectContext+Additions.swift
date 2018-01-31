//
//  NSManagedObjectContext+Additions.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 31.01.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import CoreData

extension NSManagedObjectContext {
    
    func saveIfHasChanges() throws {
        guard hasChanges else { return }
        try save()
    }
}
