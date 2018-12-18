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
        let layoutGuide = view.safeAreaLayoutGuide
        let fullField = horizontalStackView(arrangedSubviews: [FormTextField()])
        let halfFields = withAutoLayout(horizontalStackView(
            arrangedSubviews: [FormTextField(), FormTextField()]))
        let children = [fullField, halfFields]
        children.forEach {
            view.addSubview($0)
            _ = withAutoLayout($0)
        }
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
    @IBAction func dismiss(button: UIButton) {
        dismiss(animated: true, completion: nil)
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
