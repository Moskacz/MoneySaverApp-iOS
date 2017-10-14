//
//  InitialDataPrefiller.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 10.10.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation
import MoneySaverFoundationiOS

protocol InitialDataPrefiller {
    func prefillIfNeeded()
}

class InitialDataPrefillerImpl: InitialDataPrefiller {
    

    
    func prefillIfNeeded() {
        
    }
    
    private func initialCategories() -> [TransactionCategory] {
        return [TransactionCategory(identifier: UUID(), name: "Test1", icon: UIImage(), backgroundColor: UIColor.blue)]
    }
}
