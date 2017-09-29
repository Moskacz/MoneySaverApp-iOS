//
//  CardStylePresentationController.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 29.09.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import UIKit
import MoneySaverFoundationiOS

class CardStylePresentationController: UIPresentationController {
    
    
    
    override var frameOfPresentedViewInContainerView: CGRect {
        guard var containerViewFrame = containerView?.frame else { return CGRect.zero }
        containerViewFrame.size.height *= 0.8
        containerViewFrame.origin.y += containerViewFrame.size.height * 0.2
        return containerViewFrame
    }
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        presentedView?.frame = frameOfPresentedViewInContainerView
    }
    
    override func size(forChildContentContainer container: UIContentContainer,
                       withParentContainerSize parentSize: CGSize) -> CGSize {
        return CGSize(width: parentSize.width, height: parentSize.height * 0.8)
    }
    
    private func dimmingView() -> UIView {
        let dimmingView = UIView()
        dimmingView.translatesAutoresizingMaskIntoConstraints = false
        dimmingView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        dimmingView.alpha = 0.0
        return dimmingView
    }
    
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        let backgroundView = dimmingView()
        containerView?.insertSubview(backgroundView, at: 0)
        
        
    }
    
}
