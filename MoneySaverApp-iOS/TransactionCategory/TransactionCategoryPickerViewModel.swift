//
//  TransactionCategoryPickerViewModel.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 08.10.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import UIKit
import CoreData

class TmpViewModel: TransactionCategoryCellViewModel {
    func categoryName() -> String? {
        return "test"
    }
    
    func categoryIcon() -> UIImage? {
        return nil
    }
    
    func backgroundColor() -> UIColor? {
        return UIColor.orange
    }
}

class TransactionCategoryPickerViewModel  {
    
    private let repository: TransactionCategoryRepository
    private let logger: Logger
    
    private var collectionUpdater: CollectionUpdater?
    private var collectionUpdateHandler: CoreDataCollectionUpdateHandler?
    private var categoriesFRC: NSFetchedResultsController<TransactionCategoryManagedObject>?
    
    init(repository: TransactionCategoryRepository, logger: Logger) {
        self.repository = repository
        self.logger = logger
    }
    
    func attach(updater: CollectionUpdater, logger: Logger) {
        collectionUpdater = updater
        createUpdateHandler()
    }
    
    func loadData() {
        categoriesFRC = repository.allEntitiesFRC()
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
