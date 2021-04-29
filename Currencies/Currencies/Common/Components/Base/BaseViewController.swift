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
    
    let activityIndicatorOverlayView = ActivityIndicatorOverlayView()
    
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
        switch state {
        case .loaded:
            hideActivityIndicatorOverlayView()
        case .loading:
            showActivityIndicatorOverlayView(on: contentView)
        }
    }
}

extension BaseViewController {
    func showActivityIndicatorOverlayView(on view: UIView? = nil) {
        contentView.addSubview(activityIndicatorOverlayView)
        changeInteractions(enabled: false)
        activityIndicatorOverlayView.frame = view?.frame ?? self.view.frame
        activityIndicatorOverlayView.anchor(
            .centerY(view?.centerYAnchor ?? self.view.centerYAnchor),
            .centerX(view?.centerXAnchor ?? self.view.centerXAnchor)
        )
        
        DispatchQueue.main.async {
            self.activityIndicatorOverlayView.show()
        }
    }
    
    func hideActivityIndicatorOverlayView() {
        changeInteractions(enabled: true)
        DispatchQueue.main.async {
            self.activityIndicatorOverlayView.hide()
        }
        activityIndicatorOverlayView.removeFromSuperview()
    }
    
    private func changeInteractions(enabled: Bool) {
        view.isUserInteractionEnabled = enabled
        navigationController?.navigationBar.isUserInteractionEnabled = enabled
        tabBarController?.tabBar.isUserInteractionEnabled = enabled
    }
}
