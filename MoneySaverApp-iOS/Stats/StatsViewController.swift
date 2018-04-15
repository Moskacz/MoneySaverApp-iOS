//
//  StatsViewController.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 26.09.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import UIKit
import ScrollableGraphView

class StatsViewController: UIViewController {
    
    var viewModel: StatsViewModel?
    
    @IBOutlet private weak var segmentedControl: UISegmentedControl?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        tabBarItem = UITabBarItem(title: "Stats", image: #imageLiteral(resourceName: "stats"), selectedImage: #imageLiteral(resourceName: "stats"))
    }
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        guard let segments = viewModel?.availableGroupings else { return }
    }
}

