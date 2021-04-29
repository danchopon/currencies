import UIKit

protocol CoordinatorFactory {
    func makeTabbarCoordinator(services: Services) -> (configurator: Coordinator, toPresent: Presentable?)
    
    func makeAllCurrenciesCoordinator(navController: UINavigationController?, services: Services) -> Coordinator
    func makeMyCurrenciesCoordinator(navController: UINavigationController?, services: Services) -> Coordinator
}
