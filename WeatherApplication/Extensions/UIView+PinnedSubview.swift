//
//  UIView+PinnedSubview.swift
//  WeatherApplication
//
//  Created by Konstantin Bratchenko on 08.12.2022.
//

import UIKit

extension UIView {
    func addPinnedSubview(_ subview: UIView,
                          height: CGFloat? = nil,
                          insets: UIEdgeInsets = UIEdgeInsets(top: 0,
                                                              left: 0,
                                                              bottom: 0,
                                                              right: 0)) {
        addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            subview.topAnchor.constraint(equalTo: topAnchor, constant: insets.top),
            subview.leadingAnchor.constraint(equalTo: leadingAnchor, constant:insets.left),
            subview.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -1.0 * insets.right),
            subview.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -1.0 * insets.bottom),
        ])
        
        if let height = height {
            subview.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}
