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
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        tabBarItem = UITabBarItem(title: "Stats", image: #imageLiteral(resourceName: "stats"), selectedImage: #imageLiteral(resourceName: "stats"))
    }
    
    override func loadView() {
        super.loadView()
        
        let graphView = ScrollableGraphView(frame: .zero, dataSource: self)
        graphView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(graphView)
        graphView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        graphView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        graphView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        graphView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        graphView.tintColor = UIColor.orange
        
        graphView.addPlot(plot: BarPlot(identifier: "test"))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        
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
        return 0
    }
    
    func value(forPlot plot: Plot, atIndex pointIndex: Int) -> Double {
        return 50
    }
}
