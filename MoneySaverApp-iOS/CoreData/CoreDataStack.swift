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
    func loadStores()
    func getViewContext() -> NSManagedObjectContext
}

class CoreDataStackImplementation: CoreDataStack {
    
    private let persistentContainer: NSPersistentContainer
    private let logger: Logger
    private let notificationCenter: NotificationCenter
    private var didEnterBackgroundToken: NSObjectProtocol?
    private var willTerminateToken: NSObjectProtocol?
    
    init(logger: Logger, notificationCenter: NotificationCenter) {
        self.logger = logger
        self.notificationCenter = notificationCenter
        self.persistentContainer = NSPersistentContainer(name: "DataModel")
        registerForNotifications()
    }
    
    private func registerForNotifications() {
        didEnterBackgroundToken = notificationCenter.addObserver(forName: .UIApplicationDidEnterBackground,
                                                                 object: nil,
                                                                 queue: .main, using: { [weak self] _ in
            self?.save()
        })
        
        willTerminateToken = notificationCenter.addObserver(forName: .UIApplicationWillTerminate,
                                                            object: nil,
                                                            queue: .main,
                                                            using: { [weak self] _ in
            self?.save()
        })
    }
    
    func loadStores() {
        persistentContainer.loadPersistentStores { [weak self] (_, error) in
            if let loadError = error as NSError? {
                self?.logger.log(withLevel: .error, message: loadError.localizedDescription)
            }
        }
    }
    
    func getViewContext() -> NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    private func save() {
        do {
            try getViewContext().save()
        } catch {
            logger.log(withLevel: .error, message: error.localizedDescription)
        }
    }
    
    deinit {
        if let token = didEnterBackgroundToken {
            notificationCenter.removeObserver(token)
        }
        if let token = willTerminateToken {
            notificationCenter.removeObserver(token)
        }
    }
}
