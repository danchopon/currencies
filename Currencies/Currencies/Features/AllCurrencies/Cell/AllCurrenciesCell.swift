//
//  AllCurrenciesCell.swift
//  Currencies
//
//  Created by Daniyar Erkinov on 29/4/21.
//

import Foundation

protocol AllCurrenciesCellDelegate: AnyObject {
    func allCurrenciesCellDidTapAddButton(_ cell: AllCurrenciesCell, onIndexPath indexPath: IndexPath?)
    func allCurrenciesCellDidTapRemoveButton(_ cell: AllCurrenciesCell, onIndexPath indexPath: IndexPath?)
}

class AllCurrenciesCell: TableViewCell<AllCurrenciesCellContentView> {
    weak var delegate: AllCurrenciesCellDelegate?
    
    var indexPath: IndexPath?
    
    func configure(model: AllCurrencies.CurrencyDTO) {
        mainContentView.titleLabel.text = model.title
        
        mainContentView.actionButton.setTitle(model.buttonState.title, for: .normal)
        mainContentView.actionButton.backgroundColor = model.buttonState.backgroundColor
        
        switch model.buttonState {
        case .add:
            mainContentView.actionButton.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
        case .remove:
            mainContentView.actionButton.addTarget(self, action: #selector(didTapRemoveButton), for: .touchUpInside)
        }
    }
}

@objc private extension AllCurrenciesCell {
    func didTapAddButton() {
        delegate?.allCurrenciesCellDidTapAddButton(self, onIndexPath: indexPath)
    }
    
    func didTapRemoveButton() {
        delegate?.allCurrenciesCellDidTapRemoveButton(self, onIndexPath: indexPath)
    }
}
