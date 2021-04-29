//
//  BaseViewController.swift
//  Currencies
//
//  Created by Daniyar Erkinov on 29/4/21.
//

import UIKit

class BaseViewController<ContentView: BaseContentView, ViewModel: BaseViewModel>: UIViewController, ViewControlable {
    let contentView: ContentView
    let viewModel: ViewModel
    
    init(contentView: ContentView, viewModel: ViewModel) {
        self.contentView = contentView
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.baseDelegate = self
        contentView.setProperties()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSubviews()
        setConstraints()
    }
    
    func setSubviews() {
        view.addSubview(contentView)
    }
    
    func setConstraints() {
        contentView.fillSuperview()
    }
}

extension BaseViewController: BaseViewModelDelegate {
    func viewModel(_ viewModel: ViewModelable, didUpdateLoadingState state: LoadingState) {
        
    }
}
