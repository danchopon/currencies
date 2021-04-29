import UIKit

protocol TabbarView: AnyObject {
    var onAllCurrenciesFlowSelect: ((UINavigationController) -> ())? { get set }
    var onMyCurrenciesFlowSelect: ((UINavigationController) -> ())? { get set }
    
    var onViewDidLoad: ((UINavigationController) -> ())? { get set }
}
