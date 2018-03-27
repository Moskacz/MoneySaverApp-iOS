//
//  TransactionsSummaryViewController.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 22.03.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import UIKit
import MMFoundation

class TransactionsSummaryViewController: UIViewController {
    
    private var gradientView: GradientView {
        return view as! GradientView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gradientView.gradient = Gradients.activeElement
    }
}
