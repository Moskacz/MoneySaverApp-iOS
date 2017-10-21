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
    func getViewContext(completion: @escaping ((NSManagedObjectContext) -> Void))
}

class CoreDataStackImplementation: CoreDataStack {
    
    private let persistentContainer: NSPersistentContainer
    private let logger: Logger
    private var persistentContainerLoaded = false
    private var completionBlocks = [((NSManagedObjectContext) -> Void)]()
    
    init(logger: Logger) {
        self.logger = logger
        self.persistentContainer = NSPersistentContainer(name: "DataModel")
        self.persistentContainer.loadPersistentStores { [weak self] (_, error) in
            if let loadError = error as NSError? {
                self?.logger.log(withLevel: .error, message: loadError.localizedDescription)
            } else {
                self?.persistentContainerLoaded = true
                if let context = self?.persistentContainer.viewContext {
                    self?.callCompletionBlocks(context)
                }
            }
        }
    }
    
    // MARK: CoreDataStack
    
    func getViewContext(completion: @escaping ((NSManagedObjectContext) -> Void)) {
        if persistentContainerLoaded {
            completion(persistentContainer.viewContext)
        } else {
            completionBlocks.append(completion)
        }
    }
    
    private func callCompletionBlocks(_ context: NSManagedObjectContext) {
        for block in completionBlocks {
            block(context)
        }
    }
}
