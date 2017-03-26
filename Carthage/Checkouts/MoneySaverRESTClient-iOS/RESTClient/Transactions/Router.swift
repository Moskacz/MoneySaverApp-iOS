//
//  Router.swift
//  RESTClient
//
//  Created by Michał Moskała on 23.03.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation

protocol Router {
    func getAllURL() -> URL
    func postURL(entityID identifier: String) -> URL
    func putURL(entityID identifier: String) -> URL
    func deleteURL(entityID identifier: String) -> URL
}
