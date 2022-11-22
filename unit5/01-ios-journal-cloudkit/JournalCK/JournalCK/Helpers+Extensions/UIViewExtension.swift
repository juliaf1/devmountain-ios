//
//  UIViewExtension.swift
//  JournalCK
//
//  Created by Julia Frederico on 22/11/22.
//

import UIKit

extension UIView {

    func anchor(top: NSLayoutYAxisAnchor?, bottom: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, trailing: NSLayoutXAxisAnchor?, marginTop: CGFloat, marginBottom: CGFloat, marginLeft: CGFloat, marginRight: CGFloat, width: CGFloat? = nil, height: CGFloat? = nil) {

        self.translatesAutoresizingMaskIntoConstraints = false

        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: marginTop).isActive = true
        }

        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -marginBottom).isActive = true
        }

        if let leading = leading {
            self.leadingAnchor.constraint(equalTo: leading, constant: marginLeft).isActive = true
        }

        if let trailing = trailing {
            self.trailingAnchor.constraint(equalTo: trailing, constant: -marginRight).isActive = true
        }

        if let width = width {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }

        if let height = height {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    func aspectRatio(multiplier: CGFloat) {
        self.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: multiplier).isActive = true
    }
    
}
