//
//  SynchronizationService.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 24.09.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation
import CloudKit

class SynchronizationService {
    
    let database = CKContainer.default()
    
    init() {
        startSynchronization()
    }
    
    private func startSynchronization() {
        
    }
}
