//
//  CurrenciesLocalRepository.swift
//  Currencies
//
//  Created by Daniyar Erkinov on 30/4/21.
//

import Foundation
import CoreStore

final class CurrenciesLocalRepository: CurrenciesRepository {
    
    let localService = CurrenciesLocalService()
    
    func getCurrencies(completion: @escaping CurrenciesResponse) {
        localService.fetchAll { result in
            switch result {
            case .success(let currencies):
//                let mappedCurrencies = currencies.map {
//                    AllCurrencies.Currency(key: $0.$currencyKey, value: $0.$value)
//                }
//                completion(.success(mappedCurrencies))
//                currencies.forEach {
//                }
//                currencies.
                currencies.forEach {
                    print($0.cs_toRaw().getValue(forKvcKey: "currencyKey"))
                    
                }
                
            break
            case .failure(let error):
                completion(.failure(.requestMapping(error.localizedDescription)))
            }
        }
    }
    
    func remove(item: AllCurrencies.CurrencyDTO, completion: @escaping ((Error?) -> Void)) {
        localService.remove(currencyKey: item.currency.key, completion: completion)
    }
    
    func add(item: AllCurrencies.CurrencyDTO, completion: @escaping ((Error?) -> Void)) {
        localService.add(currency: item.currency, completion: completion)
    }
}
