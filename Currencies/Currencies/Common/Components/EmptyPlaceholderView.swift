//
//  EmptyPlaceholderView.swift
//  Currencies
//
//  Created by Daniyar Erkinov on 29/4/21.
//

import UIKit

class EmptyPlaceholderView: UIView {
    enum State {
        case hidden
        case visible
    }
    
    struct Preset {
        let image: UIImage?
        let attributedString: NSAttributedString
        
        static var normalAttributes: [NSAttributedString.Key: Any] {
            return [
                .font: UIFont.systemFont(ofSize: 16, weight: .regular),
                .foregroundColor: UIColor.gray
            ]
        }
        
        static var highlightAttributes: [NSAttributedString.Key: Any] {
            return [
                .font: UIFont.systemFont(ofSize: 16, weight: .bold),
                .foregroundColor: UIColor.systemPurple
            ]
        }
    }
    
    enum PlaceholderType {
        case common
        case search(highlightText: String)
        case custom(title: String, image: UIImage?)
        
        var preset: EmptyPlaceholderView.Preset {
            switch self {
            case .common:
                let attributedString = NSAttributedString(string: "No currencies", attributes: Preset.normalAttributes)
                return EmptyPlaceholderView.Preset(image: UIImage(named: "empty_box"), attributedString: attributedString)
            case .search(let highlightText):
                let attributedString = NSMutableAttributedString(string: "No currencies for ", attributes: Preset.normalAttributes)
                let highlightAttributedString = NSAttributedString(string: " \"\(highlightText)\" ", attributes: Preset.highlightAttributes)
                let endingAttributedString = NSAttributedString(string: " found.", attributes: Preset.normalAttributes)
                attributedString.append(highlightAttributedString)
                attributedString.append(endingAttributedString)
                return EmptyPlaceholderView.Preset(image: UIImage(named: "nothing_found"), attributedString: attributedString)
            case .custom(let title, let image):
                let attributedString = NSAttributedString(string: title, attributes: Preset.normalAttributes)
                return EmptyPlaceholderView.Preset(image: image, attributedString: attributedString)
            }
        }
    }
    
    lazy var emptyBoxImageView = makeEmptyBoxImageView()
    lazy var titleLabel = makeTitleLabel()
    
    let preset: Preset
    
    init(preset: Preset) {
        self.preset = preset
        super.init(frame: .zero)
        setSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EmptyPlaceholderView: BaseContentView {
    func setSubviews() {
        addSubview(emptyBoxImageView)
        addSubview(titleLabel)
    }
    
    func setConstraints() {
        emptyBoxImageView.anchor(
            .centerY(centerYAnchor, constant: -40),
            .centerX(centerXAnchor)
        )
        titleLabel.anchor(
            .top(emptyBoxImageView.bottomAnchor, constant: 12),
            .leading(leadingAnchor, constant: 50),
            .trailing(trailingAnchor, constant: 50)
        )
    }
}

private extension EmptyPlaceholderView {
    func makeEmptyBoxImageView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = preset.image
        return view
    }
    
    func makeTitleLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.attributedText = preset.attributedString
        return label
    }
}
