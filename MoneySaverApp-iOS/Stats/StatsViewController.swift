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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTestGraph()
    }
    
    private func setupTestGraph() {
        let graphView = ScrollableGraphView(frame: .zero, dataSource: self)
        graphView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(graphView)
        graphView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        graphView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        graphView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        graphView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        
        let plot = BarPlot(identifier: "test")
        graphView.addPlot(plot: plot)
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
