//
//  ViewController.swift
//  WhatToDo
//
//  Created by Alex on 12/12/18.
//  Copyright © 2018 Alex. All rights reserved.
//

import UIKit
import WhatToDoLogic

class HomeVC: UIViewController {
    @IBOutlet weak var label: UILabel!
    var subscriptionId: SubscriptionId?
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        shell.receive(.todo(.suggest))
        subscriptionId = shell.subscribe(subscription: render)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        subscriptionId.map { shell.unsubscribe(subscriptionId: $0) }

    }
    func render(state: State) {
        let todos = state.todoState.todos
        if !todos.isEmpty {
            label.text = todos[0].title
        }
    }
}
