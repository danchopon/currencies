//
//  CurrenciesDataManager.swift
//  Currencies
//
//  Created by Daniyar Erkinov on 30/4/21.
//

import Foundation

class CurrenciesDataManager<T: CurrenciesRepository> {
    enum RepositoryType {
        case local
        case remote(networkManager: NetworkManager)
    }
    
    let currenciesRepository: T
    
    init(repositoryType: RepositoryType) {
        switch repositoryType {
        case .local:
            self.currenciesRepository = CurrenciesLocalRepository() as! T
        case .remote(let networkManager):
            self.currenciesRepository = CurrenciesRemoteRepository(networkManager: networkManager) as! T
        }
    }
    
    func getCurrencies(completion: @escaping (Result<[AllCurrencies.CurrencyDTO], T.SomeError>) -> Void) {
        currenciesRepository.getCurrencies(completion: { result in
            switch result {
            case .success(let response):
                var dto = [AllCurrencies.CurrencyDTO]()
                for (key, value) in response.rates {
                    dto.append(AllCurrencies.CurrencyDTO(title: "\(key)-\(value)", buttonState: .add))
                }
                completion(.success(dto))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
}
