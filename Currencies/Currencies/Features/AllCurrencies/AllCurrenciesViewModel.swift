//
//  AllCurrenciesViewModel.swift
//  Currencies
//
//  Created by Daniyar Erkinov on 29/4/21.
//

import Foundation

protocol AllCurrenciesViewModelDelegate: AnyObject {
    func allCurrenciesViewModelDidUpdateItems(_ viewModel: AllCurrenciesViewModel)
    func allCurrenciesViewModel(_ viewModel: AllCurrenciesViewModel, didFailWithError error: NetworkError)
}

class AllCurrenciesViewModel: BaseViewModel {
    enum SearchMode {
        case normal
        case search
    }
    
    weak var delegate: AllCurrenciesViewModelDelegate?
    
    private let dataManager: CurrenciesDataManager
    private let services: Services
    
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
    
    init(services: Services) {
        self.services = services
        self.dataManager = CurrenciesDataManager(repositoryType: .remote(networkManager: services.networkManager))
        super.init()
    }
    
    func getCurrencies() {
        startIndicator()
        dataManager.getCurrencies { [weak self] result in
            self?.stopIndicator()
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.items = response
            case .failure(let error):
                self.delegate?.allCurrenciesViewModel(self, didFailWithError: error)
            }
        }
    }
    
    func addCurrency(at index: Int) {
        dataManager.setupRepository(type: .local)
        let item = item(at: index)
        dataManager.add(item: item) { [weak self] in
            self?.setupRemoteDataManagerRepository()
        }
    }
    
    func removeCurrency(at index: Int) {
        dataManager.setupRepository(type: .local)
        let item = item(at: index)
        dataManager.remove(item: item) { [weak self] in
            self?.setupRemoteDataManagerRepository()
        }
    }
    
    private func setupRemoteDataManagerRepository() {
        dataManager.setupRepository(type: .remote(networkManager: services.networkManager))
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
            return item.currencyKey.lowercased().range(of: text.lowercased(), range: nil, locale: nil) != nil
        }
        completion()
    }
}
