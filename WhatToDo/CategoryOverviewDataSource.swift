//
//  SuggestedTodoDataSource.swift
//  WhatToDo
//
//  Created by Alex on 12/18/18.
//  Copyright © 2018 Alex. All rights reserved.
//

import UIKit
import WhatToDoLogic

class CategoryOverviewDataSource: NSObject, UITableViewDataSource {
    let overviewCount = 4
    var subscriptionId: SubscriptionId?
    var todos: [Todo] = []
    weak var tableView: UITableView?
    convenience init(forTableView tableView: UITableView) {
        self.init()
        self.tableView = tableView
        tableView.register(SuggestedTodoTVC.self, forCellReuseIdentifier: "SuggestedTodoTVC")
        subscriptionId = shell.subscribe { [weak self] state in
            self?.handleNewState(state)
        }
    }
    override init() {
        super.init()
    }
    deinit {
        subscriptionId.map { shell.unsubscribe(subscriptionId: $0) }
    }
    func handleNewState(_ state: State) {
        todos = Array(state.todoState.todos[0..<overviewCount])
        tableView?.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SuggestedTodoTVC", for: indexPath) as! SuggestedTodoTVC
        return cell
    }
}
