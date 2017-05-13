//
//  NetworkingLayerAssembler.swift
//  MoneySaverApp-iOS
//
//  Created by Michał Moskała on 03.04.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation
import Dip
import RESTClient

struct NetworkingLayerAssembler: ContainerAssembly {
    
    func assembly(container: DependencyContainer) {
        container.register {
            RESTClientInterface(baseURL: URL(string: "http://192.168.1.10:3000")!).transactionsRESTClient() as TransactionsRESTClient
        }
    }
}
