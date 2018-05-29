import UIKit

final class HorizontalShiftTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
    
    private let transitionDuration = TimeInterval(0.3)
    private let navigationOperation: UINavigationControllerOperation
    
    init(navigationOperation: UINavigationControllerOperation) {
        self.navigationOperation = navigationOperation
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return transitionDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let destinationView = transitionContext.view(forKey: .to),
            let destinationViewController = transitionContext.viewController(forKey: .to) else { return }
        
        let containerView = transitionContext.containerView
        
        containerView.addSubview(destinationView)
        destinationView.frame = destinationViewInitialFrame(transitionContext: transitionContext)
        
        let originView = transitionContext.view(forKey: .from)
        
        UIView.animate(withDuration: transitionDuration, delay: 0, options: .curveEaseInOut, animations: {
            destinationView.frame = transitionContext.finalFrame(for: destinationViewController)
            originView?.frame = self.originViewInitialFrame(transitionContext: transitionContext)
        }, completion: { didComplete in
            transitionContext.completeTransition(didComplete)
        })
    }
    
    private func destinationViewInitialFrame(transitionContext: UIViewControllerContextTransitioning) -> CGRect {
        let containerView = transitionContext.containerView
        switch navigationOperation {
        case .push:
            return containerView.frame.offsetBy(dx: containerView.bounds.width , dy: 0)
        case .pop:
            return containerView.frame.offsetBy(dx: -containerView.bounds.width , dy: 0)
        default:
            return containerView.frame
        }
    }
    
    private func originViewInitialFrame(transitionContext: UIViewControllerContextTransitioning) -> CGRect {
        let containerView = transitionContext.containerView
        switch navigationOperation {
        case .push:
            return containerView.frame.offsetBy(dx: -containerView.bounds.width , dy: 0)
        case .pop:
            return containerView.frame.offsetBy(dx: containerView.bounds.width , dy: 0)
        default:
            return containerView.frame
        }
    }
}
