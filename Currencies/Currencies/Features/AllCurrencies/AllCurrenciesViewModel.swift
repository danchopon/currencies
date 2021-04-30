//
//  AllCurrenciesViewModel.swift
//  Currencies
//
//  Created by Daniyar Erkinov on 29/4/21.
//

import Foundation

protocol AllCurrenciesViewModelDelegate: AnyObject {
    func allCurrenciesViewModelDidUpdateItems(_ viewModel: AllCurrenciesViewModel)
}

class AllCurrenciesViewModel: BaseViewModel {
    enum SearchMode {
        case normal
        case search
    }
    
    weak var delegate: AllCurrenciesViewModelDelegate?
    
    let services: Services
    
    init(services: Services) {
        self.services = services
        super.init()
    }
    
    private var searchMode: SearchMode = .normal {
        didSet {
            if searchMode == .search {
                filteredItems = items
            }
        }
    }
    
    private var items: [AllCurrencies.CurrencyDTO] = [] {
        didSet {
            delegate?.allCurrenciesViewModelDidUpdateItems(self)
        }
    }
    private var filteredItems: [AllCurrencies.CurrencyDTO] = []
    
    var resultItems: [AllCurrencies.CurrencyDTO] {
        switch searchMode {
        case .normal:
            return items
        case .search:
            return filteredItems
        }
    }
}

extension AllCurrenciesViewModel {
    func numberOfRows() -> Int {
        return resultItems.count
    }
    
    func item(at index: Int) -> AllCurrencies.CurrencyDTO {
        return resultItems[index]
    }
}

extension AllCurrenciesViewModel {
    func startSearch() {
        searchMode = .search
    }
    
    func finishSearch() {
        searchMode = .normal
    }
    
    func search(text: String, completion: (() -> Void)) {
        filteredItems = text.isEmpty ? items : items.filter { (item) -> Bool in
            return item.title.lowercased().range(of: text.lowercased(), range: nil, locale: nil) != nil
        }
        completion()
    }
}
