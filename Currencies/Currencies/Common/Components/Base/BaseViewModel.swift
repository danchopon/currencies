//
//  BaseViewModel.swift
//  Currencies
//
//  Created by Daniyar Erkinov on 29/4/21.
//

import Foundation

enum LoadingState {
    case loading
    case loaded
}

protocol BaseViewModelDelegate: AnyObject {
    func viewModel(_ viewModel: ViewModelable, didUpdateLoadingState state: LoadingState)
}

class BaseViewModel: ViewModelable {
    weak var baseDelegate: BaseViewModelDelegate?

    var loadingIndicatorState: LoadingState = .loaded {
        didSet {
            baseDelegate?.viewModel(self, didUpdateLoadingState: loadingIndicatorState)
        }
    }
    
    func startIndicator() {
        loadingIndicatorState = .loading
    }
    
    func stopIndicator() {
        loadingIndicatorState = .loaded
    }
}
