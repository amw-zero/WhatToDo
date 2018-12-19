//
//  SuggestedTodoTVC.swift
//  WhatToDo
//
//  Created by Alex on 12/18/18.
//  Copyright © 2018 Alex. All rights reserved.
//

import UIKit

class SuggestedTodoTVC: UITableViewCell {
    let label: UILabel = withAutoLayout(UILabel())
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        label.text = "Testing"
        contentView.subviews {[
            label
        ]}
        NSLayoutConstraint.activate([
            label.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            label.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
