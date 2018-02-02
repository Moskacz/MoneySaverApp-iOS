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
    
    override lazy var tabBarItem: UITabBarItem! = {
        return UITabBarItem(title: "Stats", image: #imageLiteral(resourceName: "stats"), selectedImage: #imageLiteral(resourceName: "stats"))
    }()
    
    var viewModel: StatsViewModel? {
        didSet {
            if isViewLoaded {
                setup()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        setupTitleView()
    }
    
    private func setupTitleView() {
        guard let model = viewModel else { return }
        let segmentedControl = UISegmentedControl(items: model.availableGroupings.map { $0.title })
        segmentedControl.selectedSegmentIndex = model.selectedGrouping
        segmentedControl.addTarget(self, action: #selector(selectedGroupingChanged(control:)), for: .valueChanged)
        navigationItem.titleView = segmentedControl
    }
    
    @objc private func selectedGroupingChanged(control: UISegmentedControl) {
        viewModel?.selectedGrouping = control.selectedSegmentIndex
    }
}

extension StatsViewController: ScrollableGraphViewDataSource {
    
    func label(atIndex pointIndex: Int) -> String {
        return "\(pointIndex)"
    }
    
    func numberOfPoints() -> Int {
        return 100
    }
    
    func value(forPlot plot: Plot, atIndex pointIndex: Int) -> Double {
        return Double(pointIndex)
    }
}
