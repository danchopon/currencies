//
//  AllCurrencies.Response.swift
//  Currencies
//
//  Created by Daniyar Erkinov on 3/5/21.
//

import Foundation

extension AllCurrencies {
    struct Response: Decodable {
        let base: String
        let date: String
        let rates: [String: Double]
    }
}
