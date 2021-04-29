//
//  MyCurrenciesVCFactory.swift
//  Currencies
//
//  Created by Daniyar Erkinov on 29/4/21.
//

import UIKit

protocol MyCurrenciesFactory {
    var services: Services { get set }
    init(services: Services)
    
    func makeMyCurrenciesVC() -> UIViewController
}

final class MyCurrenciesVCFactory: MyCurrenciesFactory {
    var services: Services
    
    init(services: Services) {
        self.services = services
    }
    
    func makeMyCurrenciesVC() -> UIViewController {
        return UIViewController()
    }
}
