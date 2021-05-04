//
//  AllCurrencies.Currency.swift
//  Currencies
//
//  Created by Daniyar Erkinov on 3/5/21.
//

import Foundation

extension AllCurrencies {
    class Currency: Codable {
        let key: String
        let value: Double
        
        init(key: String, value: Double) {
            self.key = key
            self.value = value
        }
    }
}
