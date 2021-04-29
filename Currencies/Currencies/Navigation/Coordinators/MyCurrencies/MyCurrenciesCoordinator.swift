//
//  MyCurrenciesCoordinator.swift
//  Currencies
//
//  Created by Daniyar Erkinov on 29/4/21.
//

import UIKit

final class MyCurrenciesCoordinator: BaseCoordinator {
    private let router: Router
    private let factory: MyCurrenciesFactory
    private let services: Services
    
    init(router: Router, factory: MyCurrenciesFactory, services: Services) {
        self.router = router
        self.factory = factory
        self.services = services
    }
    
    override func start() {
        showMyCurrencies()
    }
    
    func showMyCurrencies() {
        let vc = factory.makeMyCurrenciesVC()
        router.push(vc)
    }
}
