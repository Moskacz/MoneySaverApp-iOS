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
        gradientView.gradient = Gradient(colors: [#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)], direction: .skewLeft)
    }
}
