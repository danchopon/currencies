import UIKit

final class AppCoordinatorFactory: CoordinatorFactory {
    func makeTabbarCoordinator(services: Services) -> (configurator: Coordinator, toPresent: Presentable?) {
        let controller = TabbarController()
        let factory = AppCoordinatorFactory()
        let coordinator = TabbarCoordinator(tabbarView: controller, coordinatorFactory: factory, services: services)
        
        let allCurrenciesNavController: UINavigationController = {
            let controller = UINavigationController()
            controller.navigationBar.isHidden = true
            controller.tabBarItem = UITabBarItem(
                title: "All currencies",
                image: UIImage(named: "all_currencies_tab")!,
                selectedImage: UIImage(named: "all_currencies_tab_selected")!,
                tag: 0
            )
            return controller
        }()
        let myCurrenciesNavController: UINavigationController = {
            let controller = UINavigationController()
            controller.navigationBar.isHidden = true
            controller.tabBarItem = UITabBarItem(
                title: "My currencies",
                image: UIImage(named: "my_currencies_tab")!,
                selectedImage: UIImage(named: "my_currencies_tab_selected")!,
                tag: 1
            )
            return controller
        }()
        
        let flows = [allCurrenciesNavController, myCurrenciesNavController]
        
        controller.viewControllers = flows
        return (coordinator, controller)
    }
    
    func makeAllCurrenciesCoordinator(navController: UINavigationController?, services: Services) -> Coordinator {
        let factory = AllCurrenciesVCFactory(services: services)
        return AllCurrenciesCoordinator(router: router(navController), factory: factory, services: services)
    }
    
    func makeMyCurrenciesCoordinator(navController: UINavigationController?, services: Services) -> Coordinator {
        let factory = MyCurrenciesVCFactory(services: services)
        return MyCurrenciesCoordinator(router: router(navController), factory: factory, services: services)
    }
    
    private func router(_ navController: UINavigationController?) -> Router {
        return AppRouter(rootController: navigationController(navController))
    }
    
    private func navigationController(_ navController: UINavigationController?) -> UINavigationController {
        if let navController = navController { return navController }
        else { return UINavigationController() }
    }
}
