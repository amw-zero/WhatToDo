//
//  ViewTree.swift
//  WhatToDo
//
//  Created by Alex on 12/18/18.
//  Copyright © 2018 Alex. All rights reserved.
//

import UIKit

struct ViewTreeNode {
    let view: UIView
    var childNodes: [ViewTreeNode] = []
    mutating func children(childrenBlock: () -> [ViewTreeNode]) -> ViewTreeNode {
        childNodes = childrenBlock()
        return self
    }
}

protocol ViewTreeCreator { }

extension ViewTreeCreator where Self: UIView {
    var vt: ViewTreeNode {
        get { return ViewTreeNode(view: self, childNodes: []) }
        set { }
    }
}

extension UIView: ViewTreeCreator { }

func viewTree(_ root: ViewTreeNode) {
    for child in root.childNodes {
        root.view.addSubview(child.view)
        viewTree(child)
    }
}
