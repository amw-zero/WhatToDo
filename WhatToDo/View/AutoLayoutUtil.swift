//
//  AutoLayoutUtil.swift
//  WhatToDo
//
//  Created by Alex on 12/18/18.
//  Copyright © 2018 Alex. All rights reserved.
//

import UIKit

func horizontalStackView(arrangedSubviews: [UIView] = []) -> UIStackView {
    let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
    stackView.axis = .horizontal
    stackView.distribution = .fillEqually
    return stackView
}

func fill(_ view: UIView, inParent parent: UIView, padding: CGFloat = 0) -> [NSLayoutConstraint] {
    return [
        view.topAnchor.constraint(equalTo: parent.topAnchor, constant: padding),
        view.leftAnchor.constraint(equalTo: parent.leftAnchor, constant: padding),
        view.rightAnchor.constraint(equalTo: parent.rightAnchor, constant: -padding),
        view.bottomAnchor.constraint(equalTo: parent.bottomAnchor, constant: -padding)
    ]
}

func equalWidths(_ view: UIView, parent: UIView, padding: CGFloat = 0) -> [NSLayoutConstraint] {
    return [
        view.leftAnchor.constraint(equalTo: parent.leftAnchor, constant: padding),
        view.rightAnchor.constraint(equalTo: parent.rightAnchor, constant: -padding)
    ]
}
