//
//  TransactionCategoryManagedObject+CoreDataClass.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 03.10.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//
//

import UIKit
import CoreData

public class TransactionCategoryManagedObject: NSManagedObject {

    enum AttributesNames: String {
        case name
    }
    
    lazy var image: UIImage? = {
        guard let data = icon else { return nil }
        return UIImage(data: data as Data)
    }()
}
