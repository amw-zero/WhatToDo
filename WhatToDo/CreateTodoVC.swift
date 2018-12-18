//
//  CreateTodoVC.swift
//  WhatToDo
//
//  Created by Alex on 12/17/18.
//  Copyright © 2018 Alex. All rights reserved.
//

import UIKit
class CreateTodoVC: UIViewController {
    override func viewDidLoad() {
        let fullField = horizontalStackView(
            arrangedSubviews: [FormTextField(labelText: "Title", placeholderText: "Enter Title")])
        let halfFields = withAutoLayout(horizontalStackView(
            arrangedSubviews: [
                FormTextField(labelText: "Field 1"), FormTextField(labelText: "Field 2")]))
        let children = [fullField, halfFields]
        children.forEach {
            view.addSubview($0)
            _ = withAutoLayout($0)
        }
        activateConstraints(withChildren: (fullField, halfFields))
    }
    @IBAction func dismiss(button: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    private func activateConstraints(withChildren children: (UIView, UIView)) {
        let (fullField, halfFields) = children
        let layoutGuide = view.safeAreaLayoutGuide
        let constraints = [
            equalWidths(fullField, parent: view),
            equalWidths(halfFields, parent: view),
            [
                fullField.topAnchor.constraint(
                    equalTo: layoutGuide.topAnchor, constant: 80),
                halfFields.topAnchor.constraint(
                    equalTo: fullField.bottomAnchor, constant: 20),
                fullField.heightAnchor.constraint(equalTo: fullField.heightAnchor),
                halfFields.heightAnchor.constraint(equalTo: halfFields.heightAnchor)
            ]
            ].flatMap { $0 }
        NSLayoutConstraint.activate(constraints)
    }
}

func horizontalStackView(arrangedSubviews: [UIView] = []) -> UIStackView {
    let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
    stackView.axis = .horizontal
    stackView.distribution = .fillEqually
    return stackView
}

func fill(_ view: UIView, inParent parent: UIView) {
    NSLayoutConstraint.activate([
        view.topAnchor.constraint(equalTo: parent.topAnchor, constant: 0),
        view.leftAnchor.constraint(equalTo: parent.leftAnchor, constant: 0),
        view.rightAnchor.constraint(equalTo: parent.rightAnchor, constant: 0),
        view.bottomAnchor.constraint(equalTo: parent.bottomAnchor, constant: 0)
    ])
}

func equalWidths(_ view: UIView, parent: UIView, padding: CGFloat = 0) -> [NSLayoutConstraint] {
    return [
        view.leftAnchor.constraint(equalTo: parent.leftAnchor, constant: padding),
        view.rightAnchor.constraint(equalTo: parent.rightAnchor, constant: padding)
    ]
}
