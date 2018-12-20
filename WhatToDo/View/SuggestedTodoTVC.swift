//
//  SuggestedTodoTVC.swift
//  WhatToDo
//
//  Created by Alex on 12/18/18.
//  Copyright © 2018 Alex. All rights reserved.
//

import UIKit

class SuggestedTodoTVC: UITableViewCell {
    let icon: UIImageView = makeIcon()
    let titleLabel: UILabel = withAutoLayout(UILabel())
    let descriptionLabel: UILabel = makeDescriptionLabel()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        titleLabel.text = "Testing"
        selectionStyle = .none
        contentView.subviews {[
            icon,
            titleLabel,
            descriptionLabel
        ]}
        NSLayoutConstraint.activate(
            cellLayout()
            + titleLabelLayout()
            + iconLayout()
            + descriptionLabelLayout()
        )
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension SuggestedTodoTVC {
    func cellLayout() -> [NSLayoutConstraint] {
        return [
            contentView.heightAnchor.constraint(equalToConstant: 70)
        ]
    }
}

extension SuggestedTodoTVC {
    static func makeIcon() -> UIImageView {
        let imageView = UIImageView(image: UIImage(named: "Swan"))
        return withAutoLayout(imageView)
    }
    func iconLayout() -> [NSLayoutConstraint] {
        return [
            icon.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
            icon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            icon.heightAnchor.constraint(equalToConstant: 40),
            icon.widthAnchor.constraint(equalToConstant: 40)
        ]
    }
}

extension SuggestedTodoTVC {
    func titleLabelLayout() -> [NSLayoutConstraint] {
        return [
            titleLabel.leftAnchor.constraint(equalTo: icon.rightAnchor, constant: 8),
            titleLabel.topAnchor.constraint(equalTo: icon.topAnchor)
        ]
    }
}

extension SuggestedTodoTVC {
    static func makeDescriptionLabel() -> UILabel {
        let label = withAutoLayout(UILabel())
        label.lineBreakMode = .byTruncatingTail
        label.text = "This will be a longer description, maybe multiple lines of text"
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.numberOfLines = 2
        return label
    }
    func descriptionLabelLayout() -> [NSLayoutConstraint] {
        return [
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            descriptionLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor),
            descriptionLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20)
        ]
    }
}
