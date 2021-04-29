//
//  AllCurrenciesCV.swift
//  Currencies
//
//  Created by Daniyar Erkinov on 29/4/21.
//

import UIKit

class AllCurrenciesContentView: UIView {
    init() {
        super.init(frame: .zero)
        setSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AllCurrenciesContentView: BaseContentView {
    public func setSubviews() {
        
    }
    
    public func setConstraints() {
        
    }
}

private extension AllCurrenciesContentView {
    
}
