//
//  CurrenciesRepository.swift
//  Currencies
//
//  Created by Daniyar Erkinov on 30/4/21.
//

import Foundation

protocol CurrenciesRepository {
    associatedtype SomeError: Error
    typealias CurrenciesResponse = ((Result<AllCurrencies.Response, SomeError>) -> Void)
    
    func getCurrencies(completion: @escaping CurrenciesResponse)
}
