//
//  InsetLabel.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 02.02.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import UIKit

class InsetLabel: UILabel {
    
    var insets: UIEdgeInsets
    
    init(insets: UIEdgeInsets) {
        self.insets = insets
        super.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        self.insets = UIEdgeInsets.zero
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.insets = UIEdgeInsets.zero
        super.init(coder: aDecoder)
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        let horizontalInset = insets.left + insets.right
        let verticalInset = insets.bottom + insets.top
        return CGSize(width: size.width + horizontalInset, height: size.height + verticalInset)
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let fittingSize = super.sizeThatFits(size)
        let horizontalInset = insets.left + insets.right
        let verticalInset = insets.bottom + insets.top
        return CGSize(width: fittingSize.width + horizontalInset, height: fittingSize.height + verticalInset)
    }
}
