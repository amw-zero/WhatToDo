//
//  CreateTodoVC.swift
//  WhatToDo
//
//  Created by Alex on 12/17/18.
//  Copyright © 2018 Alex. All rights reserved.
//

import UIKit

class CreateTodoVC: UIViewController {
    let button: UIButton = CreateTodoVC.dismissButton()
    let saveButton: UIButton = CreateTodoVC.saveButton()
    let titleField: UIStackView = CreateTodoVC.titleField()
    let halfFields: UIStackView = CreateTodoVC.halfFields()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        button.addTarget(self, action: #selector(dismiss(button:)), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(save(button:)), for: .touchUpInside)
        viewTree(view.vt.children {[
            button.vt,
            titleField.vt,
            halfFields.vt,
            saveButton.vt
        ]})
        layout()
    }
    
    private func layout() {
        NSLayoutConstraint.activate([
            buttonLayout(),
            titleFieldLayout(),
            halfFieldsLayout(),
            saveButtonLayout()
        ].flatMap { $0 })
    }
}

extension CreateTodoVC {
    static func dismissButton() -> UIButton {
        let button = withAutoLayout(UIButton(type: .system))
        button.setTitle("Dismiss", for: .normal)
        return button
    }
    private func buttonLayout() -> [NSLayoutConstraint] {
        let layoutGuide = view.safeAreaLayoutGuide
        return [
            button.topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: 20),
            button.leftAnchor.constraint(equalTo: layoutGuide.leftAnchor, constant: 20)
        ]
    }
    @objc func dismiss(button: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

extension CreateTodoVC {
    static func saveButton() -> UIButton {
        let button = withAutoLayout(UIButton(type: .system))
        button.setTitle("Save", for: .normal)
        return button
    }
    private func saveButtonLayout() -> [NSLayoutConstraint] {
        let layoutGuide = view.safeAreaLayoutGuide
        return equalWidths(saveButton, parent: view, padding: 20) + [
            saveButton.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: 20),
            saveButton.heightAnchor.constraint(equalToConstant: 60)
        ]
    }
    @objc func save(button: UIButton) {
        print("save")
    }
}

extension CreateTodoVC {
    static func titleField() -> UIStackView {
        return withAutoLayout(horizontalStackView(
            arrangedSubviews: [
                FormTextField(
                    labelText: "Title",
                    placeholderText: "Enter Title")]))
    }
    func titleFieldLayout() -> [NSLayoutConstraint] {
        let layoutGuide = view.safeAreaLayoutGuide
        return equalWidths(titleField, parent: view) + [
            titleField.topAnchor.constraint(
                equalTo: layoutGuide.topAnchor,
                constant: 80),
            titleField.heightAnchor.constraint(
                    equalTo: titleField.heightAnchor),
        ]
    }
}

extension CreateTodoVC {
    static func halfFields() -> UIStackView {
        return withAutoLayout(horizontalStackView(
            arrangedSubviews: [
                FormTextField(
                    labelText: "Field 1"),
                FormTextField(
                    labelText: "Field 2")]))
    }
    func halfFieldsLayout() -> [NSLayoutConstraint] {
        return equalWidths(halfFields, parent: view) + [
            halfFields.topAnchor.constraint(
                equalTo: titleField.bottomAnchor,
                constant: 20),
            halfFields.heightAnchor.constraint(
                equalTo: halfFields.heightAnchor)
        ]
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
        view.rightAnchor.constraint(equalTo: parent.rightAnchor, constant: -padding)
    ]
}
