//
//  UITabBarItem+Extensions.swift
//  Currencies
//
//  Created by Daniyar Erkinov on 29/4/21.
//

import UIKit

extension UITabBarItem {
    convenience init(title: String, image: UIImage, selectedImage: UIImage, tag: Int) {
        self.init()
        self.title = title
        self.image = image.withRenderingMode(.alwaysTemplate)
        self.selectedImage = selectedImage.withRenderingMode(.alwaysTemplate)
        self.tag = tag
    }
}
