//
//  UIStackView + Extensions.swift
//  ItunesTestApp
//
//  Created by Николай Петров on 14.04.2022.
//

import UIKit

extension UIStackView {
    convenience init(arrangedSubviews: [UIView],
                                     axis: NSLayoutConstraint.Axis,
                                     spacing: CGFloat,
                                     distribution: UIStackView.Distribution) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.axis = axis
        self.spacing = spacing
        self.distribution = distribution
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
