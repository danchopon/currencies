//
//  AllCurrencies.StoreCurrency.swift
//  Currencies
//
//  Created by Daniyar Erkinov on 3/5/21.
//

import Foundation
import CoreStore

extension AllCurrencies {
    class StoreCurrency: CoreStoreObject, ImportableUniqueObject {
        @Field.Stored("currencyKey")
        var currencyKey: String = ""
        
        @Field.Stored("value")
        var value: Double = 0.0
        
        // MARK: ImportableObject
        
        typealias ImportSource = AllCurrencies.Currency
        
        // MARK: ImportableUniqueObject
        
        typealias UniqueIDType = String
        
        static var uniqueIDKeyPath: String = String(keyPath: \AllCurrencies.StoreCurrency.$currencyKey)
        
        static func uniqueID(from source: AllCurrencies.Currency, in transaction: BaseDataTransaction) throws -> String? {
            return source.key
        }
        
        func update(from source: AllCurrencies.Currency, in transaction: BaseDataTransaction) throws {
            self.currencyKey = source.key
            self.value = source.value
        }
    }
}
