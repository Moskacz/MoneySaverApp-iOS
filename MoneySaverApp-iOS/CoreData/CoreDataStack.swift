//
//  File.swift
//  MoneySaverApp-iOS
//
//  Created by Michał Moskała on 29.03.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation
import CoreData

protocol CoreDataStack {
    func getViewContext() -> NSManagedObjectContext
    func getBackgroundContext() -> NSManagedObjectContext
}

class CoreDataStackImplementation: CoreDataStack {
    
    private lazy var persistantContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DataModel")
        container.loadPersistentStores { (storeDescription: NSPersistentStoreDescription, error: Error?) in
            if let loadError = error as NSError? {
                print(loadError)
            }
        }
        return container
    }()
    
    // MARK: CoreDataStack
    
    func getViewContext() -> NSManagedObjectContext {
        return persistantContainer.viewContext
    }
    
    func getBackgroundContext() -> NSManagedObjectContext {
        return persistantContainer.newBackgroundContext()
    }
    
}
