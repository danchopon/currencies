//
//  AllCurrenciesVCFactory.swift
//  Currencies
//
//  Created by Daniyar Erkinov on 29/4/21.
//

import UIKit

protocol AllCurrenciesFactory {
    var services: Services { get set }
    init(services: Services)
    
    func makeAllCurrenciesViewController() -> AllCurrenciesViewController
}

final class AllCurrenciesVCFactory: AllCurrenciesFactory {
    var services: Services
    
    init(services: Services) {
        self.services = services
    }
    
    func makeAllCurrenciesViewController() -> AllCurrenciesViewController {
        let contentView = AllCurrenciesContentView()
        let viewModel = AllCurrenciesViewModel(services: services)
        return AllCurrenciesViewController(contentView: contentView, viewModel: viewModel)
    }
}
