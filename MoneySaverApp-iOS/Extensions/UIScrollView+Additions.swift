//
//  UIScrollView+Additions.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 04.01.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import UIKit

extension UIScrollView {
    
    func scrollToBottom(animated: Bool) {
        let offset = contentSize.height - bounds.size.height + contentInset.bottom
        let offsetVector = CGPoint(x: 0, y: -offset)
        setContentOffset(offsetVector, animated: animated)
    }
}
