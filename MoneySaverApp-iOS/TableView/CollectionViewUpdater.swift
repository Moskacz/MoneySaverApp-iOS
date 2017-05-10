//
//  CollectionViewUpdater.swift
//  MoneySaverApp-iOS
//
//  Created by Michał Moskała on 10.05.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import UIKit

class CollectionViewUpdater: CollectionUpdater {
    
    private weak var collectionView: UICollectionView?
    
    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
    }
    
    func beginUpdates() {
        
    }
    
    func insertRow(at indexPaths: [IndexPath]) {
        
    }
    
    func deleteRow(at indexPaths: [IndexPath]) {
        
    }
    
    func move(from fromIndexPath: IndexPath, to toIndexPath: IndexPath) {
        
    }
    
    func reload(at indexPaths: [IndexPath]) {
        
    }
    
    func endUpdates() {
        collectionView?.reloadData()
    }
    
    func reloadAll() {
        
    }
}
