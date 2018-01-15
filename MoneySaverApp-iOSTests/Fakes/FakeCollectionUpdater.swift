//
//  FakeCollectionUpdater.swift
//  MoneySaverApp-iOSTests
//
//  Created by Michal Moskala on 15.01.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import Foundation
@testable import MoneySaverApp_iOS

class FakeCollectionUpdater: CollectionUpdater {
    
    var reloadAllCalled = false
    
    func beginUpdates() {
        
    }
    
    func endUpdates() {
        
    }
    
    func insertRow(at indexPaths: [IndexPath]) {
        
    }
    
    func deleteRow(at indexPaths: [IndexPath]) {
        
    }
    
    func move(from fromIndexPath: IndexPath, to toIndexPath: IndexPath) {
        
    }
    
    func reload(at indexPaths: [IndexPath]) {
        
    }
    
    func insertSection(index: Int) {
        
    }
    
    func deleteSection(index: Int) {
        
    }
    
    func reloadAll() {
        reloadAllCalled = true
    }
    
    
}
