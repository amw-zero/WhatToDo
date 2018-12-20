//
//  TodoTVC.swift
//  WhatToDo
//
//  Created by Alex on 12/16/18.
//  Copyright © 2018 Alex. All rights reserved.
//

import UIKit

class CategoryTVC: UITableViewCell {
    let icon = makeIcon()
    let roundedContainer = CategoryTVC.roundedContainer()
    let titleLabel = CategoryTVC.titleLabel()
    let boldDescriptionLabel = CategoryTVC.boldDescriptionLabel()
    let overviewTableView = CategoryTVC.overviewTableView()
    let categoryOverviewDataSource: CategoryOverviewDataSource
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        categoryOverviewDataSource = CategoryOverviewDataSource(forTableView: overviewTableView)
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = Style.colorBlue
        contentView.backgroundColor = .clear
        overviewTableView.dataSource = categoryOverviewDataSource
        contentView.subviews {[
            roundedContainer.subviews {[
                icon,
                titleLabel,
                boldDescriptionLabel,
                overviewTableView
            ]}
        ]}
        NSLayoutConstraint.activate(
            cellLayout()
                + iconLayout()
                + roundedContainerLayout()
                + titleLabelLayout()
                + boldDescriptionLayout()
                + overviewTableViewLayout()
        )
    }
    required init?(coder aDecoder: NSCoder) {
        categoryOverviewDataSource = CategoryOverviewDataSource(forTableView: overviewTableView)
        super.init(coder: aDecoder)
    }
    func cellLayout() -> [NSLayoutConstraint] {
        return [
            contentView.heightAnchor.constraint(equalToConstant: 420)
        ]
    }
}

extension CategoryTVC {
    static func makeIcon() -> UIImageView {
        let imageView = withAutoLayout(UIImageView(image: UIImage(named: "Crown")))
        return imageView
    }
    func iconLayout() -> [NSLayoutConstraint] {
        return [
            icon.leftAnchor.constraint(equalTo: roundedContainer.leftAnchor, constant: 20),
            icon.topAnchor.constraint(equalTo: roundedContainer.topAnchor, constant: 24),
            icon.heightAnchor.constraint(equalToConstant: 40),
            icon.widthAnchor.constraint(equalToConstant: 40)
        ]
    }
}

extension CategoryTVC {
    static func roundedContainer() -> UIView {
        let view = withAutoLayout(UIView())
        view.layer.cornerRadius = 10
        view.backgroundColor = .white
        view.clipsToBounds = true
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
            titleLabel.centerXAnchor.constraint(equalTo: roundedContainer.centerXAnchor),
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
        styleTableView(tableView)
        tableView.isScrollEnabled = false
        return tableView
    }
    func overviewTableViewLayout() -> [NSLayoutConstraint] {
        return equalWidths(overviewTableView, parent: roundedContainer) + [
            overviewTableView.topAnchor.constraint(equalTo: boldDescriptionLabel.bottomAnchor, constant: 20),
            overviewTableView.bottomAnchor.constraint(equalTo: roundedContainer.bottomAnchor)
        ]
    }
}
