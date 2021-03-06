//
//  CurrenciesRepository.swift
//  Currencies
//
//  Created by Daniyar Erkinov on 30/4/21.
//

import Foundation

protocol CurrenciesRepository {
    typealias CurrenciesResponse = ((Result<[AllCurrencies.Currency], NetworkError>) -> Void)
    
    func getCurrencies(completion: @escaping CurrenciesResponse)
}
