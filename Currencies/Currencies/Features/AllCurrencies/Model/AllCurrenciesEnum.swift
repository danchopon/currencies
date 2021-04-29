//
//  AllCurrenciesEnum.swift
//  Currencies
//
//  Created by Daniyar Erkinov on 29/4/21.
//

import UIKit

enum AllCurrencies {
    struct CurrencyDTO {
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
        
        let title: String
        let buttonState: ButtonState
    }
}
