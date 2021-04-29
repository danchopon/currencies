//
//  AllCurrenciesCV.swift
//  Currencies
//
//  Created by Daniyar Erkinov on 29/4/21.
//

import UIKit

class AllCurrenciesContentView: UIView {
    lazy var refreshControl = makeRefreshControl()
    lazy var tableView = makeTableView()
    lazy var emptyPlaceholderView = makeEmptyPlaceholderView()
    
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
        addSubview(tableView)
    }
    
    public func setConstraints() {
        tableView.fillSuperview()
        emptyPlaceholderView.anchor(
            .centerX(tableView.centerXAnchor),
            .centerY(tableView.centerYAnchor),
            .width(tableView.frame.width),
            .height(tableView.frame.height)
        )
    }
}

private extension AllCurrenciesContentView {
    func makeRefreshControl() -> RefreshControl {
        return RefreshControl(tintColor: .gray)
    }
    
    func makeEmptyPlaceholderView() -> EmptyPlaceholderView {
        return EmptyPlaceholderView()
    }
    
    func makeTableView() -> TableView {
        return TableView(
            refreshControl: refreshControl,
            cells: [AllCurrenciesCell.self],
            automaticDimentioned: true,
            contentInset: UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0),
            emptyPlaceholderView: emptyPlaceholderView
        )
    }
}
