import UIKit

protocol BaseContentView: UIView, ContentViewSetupable {
    func setProperties()
}

extension BaseContentView {
    func setProperties() {
        backgroundColor = .white
    }
}
