//
//  CurrenciesLocalRepository.swift
//  Currencies
//
//  Created by Daniyar Erkinov on 30/4/21.
//

import Foundation

final class CurrenciesLocalRepository: CurrenciesRepository {
    typealias SomeError = CURError
    
    func getCurrencies(completion: @escaping CurrenciesResponse) {
        completion(.failure(.emptyData))
    }
}
