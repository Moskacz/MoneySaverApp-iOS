//
//  SectionModel.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 11.11.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation

class SectionModel<T> {
    let items: [T]
    let title: String
    
    init(items: [T], title: String) {
        self.items = items
        self.title = title
    }
}
