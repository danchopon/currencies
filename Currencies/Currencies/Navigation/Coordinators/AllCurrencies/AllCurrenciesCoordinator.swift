//
//  AllCurrenciesCoordinator.swift
//  Currencies
//
//  Created by Daniyar Erkinov on 29/4/21.
//

import UIKit

final class AllCurrenciesCoordinator: BaseCoordinator {
    private let router: Router
    private let factory: AllCurrenciesFactory
    private let services: Services
    
    init(router: Router, factory: AllCurrenciesFactory, services: Services) {
        self.router = router
        self.factory = factory
        self.services = services
    }
    
    override func start() {
        showAllCurrencies()
    }
    
    func showAllCurrencies() {
        let vc = factory.makeAllCurrenciesViewController()
        router.push(vc)
    }
}
