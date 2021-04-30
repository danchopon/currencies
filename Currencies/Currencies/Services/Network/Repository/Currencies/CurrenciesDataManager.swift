//
//  CurrenciesDataManager.swift
//  Currencies
//
//  Created by Daniyar Erkinov on 30/4/21.
//

import Foundation

class CurrenciesDataManager {
    enum RepositoryType {
        case local
        case remote(networkManager: NetworkManager)
    }
    
    var currenciesRepository: CurrenciesRepository?
    
    init(repositoryType: RepositoryType) {
        switch repositoryType {
        case .local:
            self.currenciesRepository = CurrenciesLocalRepository()
        case .remote(let networkManager):
            self.currenciesRepository = CurrenciesRemoteRepository(networkManager: networkManager)
        }
    }
    
    func setupRepository(type: RepositoryType) {
        switch type {
        case .local:
            self.currenciesRepository = CurrenciesLocalRepository()
        case .remote(let networkManager):
            self.currenciesRepository = CurrenciesRemoteRepository(networkManager: networkManager)
        }
    }
    
    func getCurrencies(completion: @escaping (Result<[AllCurrencies.CurrencyDTO], NetworkError>) -> Void) {
        currenciesRepository?.getCurrencies(completion: { result in
            switch result {
            case .success(let response):
                var dto = [AllCurrencies.CurrencyDTO]()
                for (key, value) in response.rates {
                    dto.append(AllCurrencies.CurrencyDTO(currencyKey: key, value: value, buttonState: .add))
                }
                completion(.success(dto))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    func remove(item: AllCurrencies.CurrencyDTO) {
        guard let repository = currenciesRepository as? CurrenciesLocalRepository else {
            return
        }
        repository.remove(item: item)
    }
    
    func add(item: AllCurrencies.CurrencyDTO) {
        guard let repository = currenciesRepository as? CurrenciesLocalRepository else {
            return
        }
        repository.add(item: item)
    }
}
