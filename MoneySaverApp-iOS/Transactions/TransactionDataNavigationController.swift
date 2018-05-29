import UIKit

final class TransactionDataNavigationController: UINavigationController {
    
    override func loadView() {
        super.loadView()
        navigationBar.tintColor = AppColor.activeElement.value
    }
    
}
