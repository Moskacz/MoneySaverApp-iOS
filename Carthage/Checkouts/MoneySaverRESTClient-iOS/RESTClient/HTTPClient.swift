//
//  HTTPClient.swift
//  RESTClient
//
//  Created by Michał Moskała on 15.03.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation
import RxSwift

public protocol HTTPClient {
    func performRequest(withParameters parameters: HTTPRequestParameters) -> Observable<[AnyHashable: Any]>
}
