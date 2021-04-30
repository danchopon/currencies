//
//  CurrenciesLocalRepository.swift
//  Currencies
//
//  Created by Daniyar Erkinov on 30/4/21.
//

import Foundation

final class CurrenciesLocalRepository: CurrenciesRepository {
    func getCurrencies(completion: @escaping CurrenciesResponse) {
        completion(.failure(.requestMapping("")))
    }
    
    func remove(item: AllCurrencies.CurrencyDTO) {
        print(item)
    }
    
    func add(item: AllCurrencies.CurrencyDTO) {
        print(item)
    }
}
