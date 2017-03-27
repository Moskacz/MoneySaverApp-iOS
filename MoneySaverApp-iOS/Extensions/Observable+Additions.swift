//
//  ObservableType+Additions.swift
//  MoneySaverApp-iOS
//
//  Created by Michał Moskała on 27.03.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation
import RxSwift

extension Observable {
    func mapToVoid() -> Observable<Void> {
        return map { (_) -> Void in
            return ()
        }
    }
}
