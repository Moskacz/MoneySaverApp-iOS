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
        switch navigationOperation {
        case .push:
            pushViewController(using: transitionContext)
        case .pop:
            popViewController(using: transitionContext)
        default:
            break
        }
    }
    
    private func pushViewController(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let destinationView = transitionContext.view(forKey: .to),
            let destinationViewController = transitionContext.viewController(forKey: .to) else { return }
        let containerView = transitionContext.containerView
        
        containerView.addSubview(destinationView)
        let destinationViewInitialFrame = containerView.frame.offsetBy(dx: containerView.bounds.width, dy: 0)
        let destinationViewFinalFrame = transitionContext.finalFrame(for: destinationViewController)
        
        destinationView.frame = destinationViewInitialFrame
        
        let originView = transitionContext.view(forKey: .from)
        let originViewFinalFrame = containerView.frame.offsetBy(dx: -containerView.bounds.width, dy: 0)
        
        UIView.animate(withDuration: transitionDuration, animations: {
            destinationView.frame = destinationViewFinalFrame
            originView?.frame = originViewFinalFrame
        }, completion: { didComplete in
            transitionContext.completeTransition(didComplete)
        })
    }
    
    private func popViewController(using transitionContext: UIViewControllerContextTransitioning) {}
}
