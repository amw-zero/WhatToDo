//
//  TodoTVC.swift
//  WhatToDo
//
//  Created by Alex on 12/16/18.
//  Copyright © 2018 Alex. All rights reserved.
//

import UIKit

class TodoTVC: UITableViewCell {
    let label = TodoTVC.titleLabel()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.subviews {[
            label
        ]}
        NSLayoutConstraint.activate(
            labelLayout() + cellLayout()
        )
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    func cellLayout() -> [NSLayoutConstraint] {
        return [
            contentView.heightAnchor.constraint(equalToConstant: 200)
        ]
    }
}

extension TodoTVC {
    static func titleLabel() -> UILabel {
        let label = withAutoLayout(UILabel(frame: .zero))
        label.textColor = .black
        return label
    }
    func labelLayout() -> [NSLayoutConstraint] {
        return [
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            label.centerYAnchor.constraint(lessThanOrEqualTo: contentView.centerYAnchor),
            label.heightAnchor.constraint(equalToConstant: 100)
        ]
    }
}
