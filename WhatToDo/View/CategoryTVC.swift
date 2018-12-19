//
//  TodoTVC.swift
//  WhatToDo
//
//  Created by Alex on 12/16/18.
//  Copyright © 2018 Alex. All rights reserved.
//

import UIKit

class CategoryTVC: UITableViewCell {
    let roundedContainer = CategoryTVC.roundedContainer()
    let titleLabel = CategoryTVC.titleLabel()
    let boldDescriptionLabel = CategoryTVC.boldDescriptionLabel()
    let overviewTableView = CategoryTVC.overviewTableView()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.backgroundColor = .lightGray
        contentView.subviews {[
            roundedContainer.subviews {[
                titleLabel,
                boldDescriptionLabel,
                overviewTableView
            ]}
        ]}
        NSLayoutConstraint.activate(
            roundedContainerLayout()
            + titleLabelLayout()
            + cellLayout()
            + boldDescriptionLayout()
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

extension CategoryTVC {
    static func roundedContainer() -> UIView {
        let view = withAutoLayout(UIView())
        view.layer.cornerRadius = 10
        view.backgroundColor = .white
        return view
    }
    func roundedContainerLayout() -> [NSLayoutConstraint] {
        return fill(roundedContainer, inParent: contentView, padding: 10)
    }
}

extension CategoryTVC {
    static func titleLabel() -> UILabel {
        let label = withAutoLayout(UILabel())
        label.textColor = .gray
        return label
    }
    func titleLabelLayout() -> [NSLayoutConstraint] {
        return [
            titleLabel.leftAnchor.constraint(equalTo: roundedContainer.leftAnchor, constant: 50),
            titleLabel.topAnchor.constraint(equalTo: roundedContainer.topAnchor, constant: 20)
        ]
    }
}

extension CategoryTVC {
    static func boldDescriptionLabel() -> UILabel {
        let label = withAutoLayout(UILabel())
        label.font = UIFont.boldSystemFont(ofSize: 25)
        return label
    }
    func boldDescriptionLayout() -> [NSLayoutConstraint] {
        return [
            boldDescriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            boldDescriptionLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ]
    }
}

extension CategoryTVC {
    static func overviewTableView() -> UITableView {
        let tableView = withAutoLayout(UITableView())
//        tableView.dataSource = SuggestedTodoDataSource()
//        tableView.register(SuggestedTodoTVC, forCellReuseIdentifier: "SuggestedTodoTVC")
        return tableView
    }
    func overviewTableViewLayout() -> [NSLayoutConstraint] {
        return equalWidths(overviewTableView, parent: contentView) + [
            overviewTableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            overviewTableView.heightAnchor.constraint(equalToConstant: 200)
        ]
    }
}
