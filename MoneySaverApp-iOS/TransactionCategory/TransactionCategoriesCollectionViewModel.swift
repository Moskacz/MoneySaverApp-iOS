//
//  TransactionCategoriesCollectionViewModel.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 09.10.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation
import CoreData

class TransactionCategoriesCollectionViewModel {
    
    private let service: TransactionCategoryService
    private let logger: Logger
    
    private var collectionUpdater: CollectionUpdater?
    private var collectionUpdateHandler: CoreDataCollectionUpdateHandler?
    private var categoriesFRC: NSFetchedResultsController<TransactionCategoryManagedObject>?
    
    init(service: TransactionCategoryService, logger: Logger) {
        self.service = service
        self.logger = logger
    }
    
    func attach(updater: CollectionUpdater) {
        collectionUpdater = updater
        createUpdateHandler()
    }
    
    func loadData() {
        categoriesFRC = service.allEntitiesFRC
        categoriesFRC?.delegate = collectionUpdateHandler
        
        do {
            try categoriesFRC?.performFetch()
            collectionUpdater?.reloadAll()
        } catch {
            logger.log(withLevel: .error, message: error.localizedDescription)
        }
    }
    
    private func createUpdateHandler() {
        guard let updater = collectionUpdater else { return }
        collectionUpdateHandler = CoreDataCollectionUpdateHandler(collectionUpdater: updater)
    }
    
    func numberOfItems() -> Int {
        return categoriesFRC?.fetchedObjects?.count ?? 0
    }
    
    func itemCellViewModel(forIndexPath path: IndexPath) -> TransactionCategoryCellViewModel {
        guard let object = categoriesFRC?.fetchedObjects?[path.row] else {
            fatalError("should not be called")
        }
        return TransactionCategoryCellViewModelImpl(category: object)
    }
}
