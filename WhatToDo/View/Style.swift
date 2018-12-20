//
//  Style.swift
//  WhatToDo
//
//  Created by Alex on 12/16/18.
//  Copyright © 2018 Alex. All rights reserved.
//

import UIKit

func styleTableView(_ tableView: UITableView) {
    tableView.separatorStyle = .none
}

struct Style {
    static var colorBlue: UIColor {
        return color(fromRed: 201, green: 221, blue: 255)
    }
    static func color(fromRed red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha)
    }
}

