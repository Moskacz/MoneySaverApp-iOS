//
//  ViewController.swift
//  MoneySaverApp-iOS
//
//  Created by Michał Moskała on 19.03.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import UIKit
import RESTClient
import RxSwift
import MoneySaverFoundationiOS

class ViewController: UIViewController {

    let restClient = RESTClientInterface(baseURL: URL(string: "http://localhost:3000")!)
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let transactionsClient = restClient.transactionsRESTClient()
        transactionsClient.getTransactions().subscribe(onNext: { (transactions: [Transaction]) in
            print(transactions)
        }, onError: { (error: Error) in
            print(error)
        }, onCompleted: { 
            print("completed")
        }).addDisposableTo(disposeBag)
    }
    
}

