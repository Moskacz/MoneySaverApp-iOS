//
//  InMemoryCoreDataStack.swift
//  MoneySaverApp-iOSTests
//
//  Created by Michal Moskala on 18.04.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import Foundation
import CoreData
import MoneySaverAppCore

class InMemoryCoreDataStack: CoreDataStack {
    
    private let container: NSPersistentContainer
    
    init() {
        let container = NSPersistentContainer(name: "DataModel")
        let storeDescription = NSPersistentStoreDescription()
        storeDescription.type = NSInMemoryStoreType
        container.persistentStoreDescriptions = [storeDescription]
        container.loadPersistentStores { (storeDescription, error) in
            print(storeDescription)
            if let loadingError = error {
                print(loadingError.localizedDescription)
            }
        }
        
        self.container = container
    }
    
    func getViewContext() -> NSManagedObjectContext {
        return container.viewContext
    }
    
    func save() throws {}
}
