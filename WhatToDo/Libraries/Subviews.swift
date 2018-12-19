//
//  Subviews.swift
//  Subviews
//
//  Created by Alex on 12/18/18.
//  Copyright © 2018 Alex. All rights reserved.
//

import UIKit

extension UIView {
    @discardableResult
    func subviews(_ subviewsFunc: () -> [UIView]) -> UIView {
        for subview in subviewsFunc() {
            addSubview(subview)
        }
        return self
    }
}

extension UIStackView {
    @discardableResult
    func arrangedSubviews(_ subviewsFunc: () -> [UIView]) -> UIView {
        for subview in subviewsFunc() {
            addArrangedSubview(subview)
        }
        return self
    }
}
