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
    
    private weak var dimmingView: UIView?
    
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerFrame = containerView?.frame else { return CGRect.zero }
        let origin = CGPoint(x: containerFrame.origin.x, y: containerFrame.height * 0.1)
        let frameSize = size(forChildContentContainer: presentedViewController,
                             withParentContainerSize: containerFrame.size)
        return CGRect(origin: origin, size: frameSize)
    }
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        presentedView?.frame = frameOfPresentedViewInContainerView
    }
    
    override func size(forChildContentContainer container: UIContentContainer,
                       withParentContainerSize parentSize: CGSize) -> CGSize {
        return CGSize(width: parentSize.width , height: parentSize.height * 0.9)
    }
    
    private func createDimmingView() -> UIView {
        let dimmingView = UIView()
        dimmingView.translatesAutoresizingMaskIntoConstraints = false
        dimmingView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        dimmingView.alpha = 0.0
        return dimmingView
    }
    
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        let view = createDimmingView()
        containerView?.insertSubview(view, at: 0)
        view.matchParent()
        self.dimmingView = view
        
        let animationQueued = presentedViewController.transitionCoordinator?.animate(alongsideTransition: { (_) in
            self.setupPropertiesForPresentedState()
        }, completion: nil) ?? false
        
        if !animationQueued {
            setupPropertiesForPresentedState()
        }
    }
    
    private func setupPropertiesForPresentedState() {
        dimmingView?.alpha = 1.0
        presentingViewController.view.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        setupCorner(radius: 8.0, onLayer: presentingViewController.view.layer)
        setupCorner(radius: 8.0, onLayer: presentedView?.layer)
    }
    
    override func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()
        let animationQueued = presentedViewController.transitionCoordinator?.animate(alongsideTransition: { (_) in
            self.setupPropertiesForDismissedState()
        }, completion: nil) ?? false
        
        if !animationQueued {
            self.setupPropertiesForDismissedState()
        }
    }
    
    private func setupPropertiesForDismissedState() {
        dimmingView?.alpha = 0.0
        presentingViewController.view.transform = CGAffineTransform.identity
        setupCorner(radius: 0, onLayer: presentingViewController.view.layer)
        setupCorner(radius: 0, onLayer: presentedView?.layer)
    }
    
    private func setupCorner(radius: CGFloat, onLayer layer: CALayer?) {
        layer?.masksToBounds = radius > 0
        layer?.cornerRadius = radius
    }
    
}
