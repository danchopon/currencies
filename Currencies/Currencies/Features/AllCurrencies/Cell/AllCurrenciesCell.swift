//
//  AllCurrenciesCell.swift
//  Currencies
//
//  Created by Daniyar Erkinov on 29/4/21.
//

import Foundation
class AllCurrenciesCell: TableViewCell<AllCurrenciesCellContentView> {
    func configure(model: AllCurrencies.CurrencyDTO) {
        mainContentView.titleLabel.text = model.title
        
        mainContentView.actionButton.setTitle(model.buttonState.title, for: .normal)
        mainContentView.actionButton.backgroundColor = model.buttonState.backgroundColor
    }
}
