//
//  AllCurrenciesCellContentView.swift
//  Currencies
//
//  Created by Daniyar Erkinov on 29/4/21.
//

import UIKit

class AllCurrenciesCellContentView: UIView {
    lazy var titleLabel = makeTitleLabel()
    lazy var actionButton = makeActionButton()
    lazy var separatorView = makeSeparatorView()
    
    init() {
        super.init(frame: .zero)
        setSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AllCurrenciesCellContentView: BaseContentView {
    public func setSubviews() {
        addSubview(titleLabel)
        addSubview(actionButton)
        addSubview(separatorView)
    }
    
    public func setConstraints() {
        titleLabel.anchor(
            .centerY(actionButton.centerYAnchor),
            .leading(leadingAnchor, constant: 8),
            .trailing(actionButton.leadingAnchor, constant: 8)
        )
        actionButton.anchor(
            .top(topAnchor, constant: 8),
            .trailing(trailingAnchor, constant: 8),
            .height(40),
            .width(60)
        )
        separatorView.anchor(
            .top(actionButton.bottomAnchor, constant: 8),
            .leading(titleLabel.leadingAnchor),
            .trailing(actionButton.trailingAnchor),
            .bottom(bottomAnchor)
        )
    }
}

private extension AllCurrenciesCellContentView {
    func makeTitleLabel() -> UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.textColor = UIColor.black
        return label
    }
    
    func makeActionButton() -> UIButton {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 15)
        return button
    }
    
    func makeSeparatorView() -> UIView {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }
}
