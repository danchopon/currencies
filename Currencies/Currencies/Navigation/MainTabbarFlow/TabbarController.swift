import UIKit

final class TabbarController: UITabBarController, UITabBarControllerDelegate, TabbarView {
    
    enum TabIndex: Int {
        case allCurrencies
        case myCurrencies
    }
    
    var onAllCurrenciesFlowSelect: ((UINavigationController) -> ())?
    var onMyCurrenciesFlowSelect: ((UINavigationController) -> ())?
    
    var onViewDidLoad: ((UINavigationController) -> ())?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupProperties()
        delegate = self
        if let controller = customizableViewControllers?.first as? UINavigationController {
            onViewDidLoad?(controller)
        }
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        guard let controller = viewControllers?[selectedIndex] as? UINavigationController else { return }
        
        guard let tabIndex = TabIndex(rawValue: selectedIndex) else { return }
        
        switch tabIndex {
        case .allCurrencies:
            onAllCurrenciesFlowSelect?(controller)
        case .myCurrencies:
            onMyCurrenciesFlowSelect?(controller)
        }
    }
    
    private func setupProperties() {
        tabBar.tintColor = UIColor.systemPurple
        view.backgroundColor = UIColor.white
    }
}
