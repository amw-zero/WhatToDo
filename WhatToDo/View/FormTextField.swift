//
//  FormTextField.swift
//  WhatToDo
//
//  Created by Alex on 12/17/18.
//  Copyright © 2018 Alex. All rights reserved.
//

import UIKit

func withAutoLayout<T: UIView>(_ view: T) -> T {
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
}

class FormTextField: UIView {
    let label: UILabel = withAutoLayout(UILabel())
    let textField: UITextField = withAutoLayout(UITextField())
    init(labelText: String, placeholderText: String = "") {
        super.init(frame: .zero)
        _ = withAutoLayout(self)
        addSubview(label)
        addSubview(textField)
        label.text = labelText
        textField.placeholder = placeholderText
        textField.borderStyle = .roundedRect
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func updateConstraints() {
        let padding: CGFloat = 20
        NSLayoutConstraint.activate([
            label.leftAnchor.constraint(equalTo: leftAnchor, constant: padding),
            label.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            textField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 8),
            textField.leftAnchor.constraint(equalTo: label.leftAnchor, constant: 0),
            textField.rightAnchor.constraint(equalTo: rightAnchor, constant: -padding),
            textField.heightAnchor.constraint(equalToConstant: 50),
            heightAnchor.constraint(equalToConstant: 100)
        ])
        super.updateConstraints()
    }
}
