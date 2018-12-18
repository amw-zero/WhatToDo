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
    let formField1 = FormTextField(labelText: "Field 1")
    let formField2 = FormTextField(labelText: "Field 2")
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        button.addTarget(self, action: #selector(dismiss(button:)), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(save(button:)), for: .touchUpInside)
        viewTree(.view(view, [
            .view(button, []),
            .view(titleField, []),
            .stackView(halfFields, [
                .view(formField1, []),
                .view(formField2, [])
            ]),
            .view(saveButton, [])
        ]))
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
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return withAutoLayout(stackView)
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
