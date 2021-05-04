//
//  CurrenciesLocalService.swift
//  Currencies
//
//  Created by Daniyar Erkinov on 3/5/21.
//

import CoreStore

final class CurrenciesLocalService {
    static let dataStack: DataStack = {
        let dataStack = DataStack(
            CoreStoreSchema(
                modelVersion: "V1",
                entities: [
                    Entity<AllCurrencies.StoreCurrency>("StoreCurrency")
                ],
                versionLock: [
                    "StoreCurrency": [0x60a23d2db0411409, 0xdf752a42f0bb085d, 0x7e217bb7575bd657, 0xee58768144fc3afe]
                ]
            )
        )
        
        return dataStack
    }()
    
    func fetchAll(completion: @escaping (Result<[AllCurrencies.StoreCurrency], Error>) -> Void) {
        CurrenciesLocalService.dataStack.perform { transaction in
            try transaction.fetchAll(From<AllCurrencies.StoreCurrency>())
        } completion: { result in
            switch result {
            case .success(let object):
                completion(.success(object))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func remove(currencyKey: String, completion: @escaping ((Error?) -> Void)) {
        CurrenciesLocalService.dataStack.perform { transaction in
            try transaction.deleteAll(
                From<AllCurrencies.StoreCurrency>(),
                Where<AllCurrencies.StoreCurrency>("%K = %@", "currencyKey", currencyKey)
            )
        } completion: { result in
            switch result {
            case .success:
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    func add(currency: AllCurrencies.Currency, completion: @escaping ((Error?) -> Void)) {
        CurrenciesLocalService.dataStack.perform { transaction in
            let object = transaction.create(Into<AllCurrencies.StoreCurrency>())
            object.currencyKey = currency.key
            object.value = currency.value
        } completion: { result in
            switch result {
            case .success:
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }
}
