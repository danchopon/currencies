//
//  AllCurrenciesViewModel.swift
//  Currencies
//
//  Created by Daniyar Erkinov on 29/4/21.
//

import Foundation

class AllCurrenciesViewModel: BaseViewModel {
    enum SearchMode {
        case normal
        case search
    }
    
    private var searchMode: SearchMode = .normal
    
    private var items: [AllCurrencies.CurrencyDTO] = []
    private var searchItems: [AllCurrencies.CurrencyDTO] = []
    
    var resultItems: [AllCurrencies.CurrencyDTO] {
        switch searchMode {
        case .normal:
            return items
        case .search:
            return searchItems
        }
    }
}
