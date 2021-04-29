import UIKit

class TabbarCoordinator: BaseCoordinator {
    
    private let tabbarView: TabbarView
    private let coordinatorFactory: CoordinatorFactory
    private let services: Services
    
    init(tabbarView: TabbarView, coordinatorFactory: CoordinatorFactory, services: Services) {
        self.tabbarView = tabbarView
        self.coordinatorFactory = coordinatorFactory
        self.services = services
    }
    
    override func start() {
        tabbarView.onViewDidLoad = runAllCurrenciesFlow()
        tabbarView.onAllCurrenciesFlowSelect = runAllCurrenciesFlow()
        tabbarView.onMyCurrenciesFlowSelect = runMyCurrenciesFlow()
    }
    
    private func runAllCurrenciesFlow() -> ((UINavigationController) -> ()) {
        return { [unowned self] navController in
            if navController.viewControllers.isEmpty {
                let coordinator = self.coordinatorFactory.makeAllCurrenciesCoordinator(navController: navController, services: services)
                self.addDependency(coordinator)
                coordinator.start()
            }
        }
    }
    
    private func runMyCurrenciesFlow() -> ((UINavigationController) -> ()) {
        return { [unowned self] navController in
            if navController.viewControllers.isEmpty {
                let coordinator = self.coordinatorFactory.makeMyCurrenciesCoordinator(navController: navController, services: services)
                self.addDependency(coordinator)
                coordinator.start()
            }
        }
    }
}
