import UIKit

final class AppCoordinator: BaseCoordinator {
    private let coordinatorFactory: CoordinatorFactory
    private let router: Router
    private var services: Services
    private var options: DeepLinkOption?
    
    init(router: Router, coordinatorFactory: CoordinatorFactory, services: Services) {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
        self.services = services
        super.init()
    }
    
    override func start(with options: DeepLinkOption?) {
        self.options = options
        runFlow()
    }
    
    private func runFlow() {
        if let options = self.options {
            //start with deepLink
            switch options {
            default:
                childCoordinators.forEach { coordinator in
                    coordinator.start(with: options)
                }
            }
        } else {
            // default start
            switch services.instructor.startOption {
            case .main: runMainFlow()
            }
        }
    }
    
    private func runMainFlow() {
        let (coordinator, module) = coordinatorFactory.makeTabbarCoordinator(services: services)
        addDependency(coordinator)
        router.setRootModule(module, hideBar: true)
        coordinator.start()
    }
}
