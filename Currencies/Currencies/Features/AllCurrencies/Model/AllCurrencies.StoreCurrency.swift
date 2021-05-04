//
//  AllCurrencies.StoreCurrency.swift
//  Currencies
//
//  Created by Daniyar Erkinov on 3/5/21.
//

import Foundation
import CoreStore

extension AllCurrencies {
    class StoreCurrency: CoreStoreObject {
        @Field.Stored("currencyKey")
        var currencyKey: String = ""
        
        @Field.Stored("value")
        var value: Double = 0.0
    }
}
extension AllCurrencies.StoreCurrency {
    func toDict() -> Dictionary<String, Any> {
        var dict = Dictionary<String, Any>()
        self.cs_toRaw().entity.attributesByName.forEach { (field, value) in
            dict[field] = self.cs_toRaw().getValue(forKvcKey: field)
        }
        return dict
    }
}
