//
//  ViewTree.swift
//  WhatToDo
//
//  Created by Alex on 12/18/18.
//  Copyright © 2018 Alex. All rights reserved.
//

import UIKit

enum Node {
    case view(UIView, [Node])
    case stackView(UIStackView, [Node])
    var view: UIView {
        switch self {
        case let .view(view, _):
            return view
        case let .stackView(view, _):
            return view
        }
    }
}

func viewTree(_ root: Node) {
    switch root {
    case let .view(uiView, children):
        for child in children {
            uiView.addSubview(child.view)
            viewTree(child)
        }
    case let .stackView(stackView, children):
        for child in children {
            stackView.addArrangedSubview(child.view)
            viewTree(child)
        }
    }
}
