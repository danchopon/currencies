//
//  AllCurrenciesCellContentView.swift
//  Currencies
//
//  Created by Daniyar Erkinov on 29/4/21.
//

import UIKit

class AllCurrenciesCellContentView: UIView {
    lazy var keyTitleLabel = makeKeyTitleLabel()
    lazy var valueLabel = makeValueLabel()
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
        addSubview(keyTitleLabel)
        addSubview(valueLabel)
        addSubview(actionButton)
        addSubview(separatorView)
    }
    
    public func setConstraints() {
        keyTitleLabel.anchor(
            .centerY(actionButton.centerYAnchor),
            .leading(leadingAnchor, constant: 16)
        )
        valueLabel.anchor(
            .centerY(actionButton.centerYAnchor),
            .leading(keyTitleLabel.trailingAnchor, constant: 8),
            .trailing(actionButton.leadingAnchor, constant: 8)
        )
        actionButton.anchor(
            .top(topAnchor, constant: 8),
            .trailing(trailingAnchor, constant: 16),
            .height(35),
            .width(70)
        )
        separatorView.anchor(
            .top(actionButton.bottomAnchor, constant: 8),
            .leading(keyTitleLabel.leadingAnchor),
            .trailing(actionButton.trailingAnchor),
            .bottom(bottomAnchor),
            .height(1)
        )
        valueLabel.setContentHuggingPriority(UILayoutPriority(48), for: .horizontal)
        valueLabel.setContentCompressionResistancePriority(UILayoutPriority(749), for: .horizontal)
    }
}

private extension AllCurrenciesCellContentView {
    func makeKeyTitleLabel() -> UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.textColor = UIColor.black
        return label
    }
    
    func makeValueLabel() -> UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = UIColor.systemPurple
        return label
    }
    
    func makeActionButton() -> UIButton {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 15)
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }
    
    func makeSeparatorView() -> UIView {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }
}
