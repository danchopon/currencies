//
//  CurrenciesRemoteRepository.swift
//  Currencies
//
//  Created by Daniyar Erkinov on 30/4/21.
//

import Moya

final class CurrenciesRemoteRepository: CurrenciesRepository {
    typealias SomeError = NetworkError
    
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func getCurrencies(completion: @escaping CurrenciesResponse) {
        let target = CurrenciesAPI.latest
        networkManager.request(MultiTarget(target), for: AllCurrencies.Response.self) { result in
            switch result {
            case .success(let response):
                var currencies = [AllCurrencies.Currency]()
                for (key, value) in response.rates {
                    currencies.append(AllCurrencies.Currency(key: key, value: value))
                }
                completion(.success(currencies))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
