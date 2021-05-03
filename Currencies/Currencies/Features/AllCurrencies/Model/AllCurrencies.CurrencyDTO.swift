//
//  AllCurrencies.CurrencyDTO.swift
//  Currencies
//
//  Created by Daniyar Erkinov on 3/5/21.
//

import UIKit

extension AllCurrencies {
    class CurrencyDTO {
        enum ButtonState {
            case add
            case remove
            
            var title: String {
                switch self {
                case .add:
                    return "Add"
                case .remove:
                    return "Remove"
                }
            }
            
            var backgroundColor: UIColor {
                switch self {
                case .add:
                    return UIColor.systemGreen
                case .remove:
                    return UIColor.systemRed
                }
            }
        }
        
        let currency: Currency
        let buttonState: ButtonState
        
        init(currency: Currency, buttonState: ButtonState) {
            self.currency = currency
            self.buttonState = buttonState
        }
        
        var valueDTO: String {
            return "\(currency.value)"
        }
    }
}
