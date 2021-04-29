import UIKit

class BaseNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.isHidden = true
    }
    
    /// This method removes all controllers from the stack without unwanted transitions
    func popToRoot() {
        guard let root = viewControllers.first else { return }
        setViewControllers([root], animated: false)
    }
}
