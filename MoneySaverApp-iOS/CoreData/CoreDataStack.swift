//
//  File.swift
//  MoneySaverApp-iOS
//
//  Created by Michał Moskała on 29.03.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation
import CoreData

protocol CoreDataStack: class {
    var isLoaded: Bool { get }
    func loadStores(completion: @escaping (() -> Void))
    func getViewContext() -> NSManagedObjectContext
}

class CoreDataStackImplementation: CoreDataStack {
    
    private let persistentContainer: NSPersistentContainer
    private let logger: Logger
    var isLoaded: Bool = false
    
    init(logger: Logger) {
        self.logger = logger
        self.persistentContainer = NSPersistentContainer(name: "DataModel")
    }
    
    func loadStores(completion: @escaping (() -> Void)) {
        persistentContainer.loadPersistentStores { [weak self] (_, error) in
            if let loadError = error as NSError? {
                self?.logger.log(withLevel: .error, message: loadError.localizedDescription)
            }
            self?.isLoaded = true
            completion()
        }
    }
    
    // MARK: CoreDataStack
    
    func getViewContext() -> NSManagedObjectContext {
        return persistentContainer.viewContext
    }
}
