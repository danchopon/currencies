//
//  AppDelegate.swift
//  Currencies
//
//  Created by Daniyar Erkinov on 29/4/21.
//

import Moya
import UIKit
import CoreStore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    lazy var rootViewController = makeRootViewController()
    lazy var appCoordinator = makeAppCoordinator()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupWindow()
        appCoordinator.start(with: option(from: launchOptions))
        NetworkActivityLogger.shared.level = .debug
        NetworkActivityLogger.shared.startLogging()
        setupCoreStoreDataStack()
        return true
    }

}

private extension AppDelegate {
    private func makeAppCoordinator() -> Coordinator {
        let instructor = LaunchInstructor()
        let router = AppRouter(rootController: rootViewController)
        let appCoordinatorFactory = AppCoordinatorFactory()
        let networkManager = makeNetworkManager()

        let appServices = AppServices(
            instructor: instructor,
            networkManager: networkManager
        )
        return AppCoordinator(
            router: router,
            coordinatorFactory: appCoordinatorFactory,
            services: appServices
        )
    }
    
    private func setupWindow() {
        window = UIWindow()
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
    }
    
    private func makeRootViewController() -> BaseNavigationController {
        return BaseNavigationController()
    }
    
    private func option(from launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> DeepLinkOption? {
        let launchOptions = launchOptions?[.remoteNotification] as? [String: AnyObject]
        let deepLink = DeepLinkOption.build(with: launchOptions)
        return deepLink
    }
    
    private func makeNetworkManager() -> NetworkManager {
        let networkLoggerPlugin = NetworkLoggerPlugin(configuration: NetworkLoggerPlugin.Configuration(logOptions: .verbose))
        let provider = MoyaProvider<MultiTarget>(plugins: [networkLoggerPlugin])
        let networkManager = NetworkManager(provider: provider)
        return networkManager
    }
    
    private func setupCoreStoreDataStack() {
        do {
            try CurrenciesLocalService.dataStack.addStorageAndWait(
                SQLiteStore(
                    fileName: "StoreCurrency.sqlite",
                    localStorageOptions: .recreateStoreOnModelMismatch
                ))
        } catch {
            print(error)
        }
    }
}
