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
    let paginationThreshold = 5
    var subscriptionId: SubscriptionId?
    var todos: [Todo] = []
    let tableView = withAutoLayout(UITableView(frame: .zero))
    let addTodoButton = HomeVC.addTodoButton()
    func render(state: State) {
        todos = state.todoState.todos
        tableView.reloadData()
    }
    func tableViewLayout() -> [NSLayoutConstraint] {
        let layoutGuide = view.safeAreaLayoutGuide
        return [
            tableView.leftAnchor.constraint(equalTo: layoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: layoutGuide.rightAnchor),
            tableView.topAnchor.constraint(equalTo: layoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor)
        ]
    }
}
    
// MARK: UIViewController Lifecycle Methods
extension HomeVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        styleTableView(tableView)
        tableView.register(TodoTVC.self, forCellReuseIdentifier: "TodoTVC")
        tableView.dataSource = self
        addTodoButton.addTarget(self, action: #selector(addTodo(button:)), for: .touchUpInside)
        view.subviews {[
            tableView,
            addTodoButton
        ]}
        NSLayoutConstraint.activate(
            tableViewLayout() + addButtonLayout()
        )
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        shell.receive(.todo(.fetchSuggestedPage))
        subscriptionId = shell.subscribe(subscription: render)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        subscriptionId.map { shell.unsubscribe(subscriptionId: $0) }
    }
}

// MARK: UITableViewDataSource
extension HomeVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row > (todos.count - paginationThreshold)   {
            shell.receive(.todo(.fetchSuggestedPage))
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoTVC") as! TodoTVC
        cell.label.text = todos[indexPath.row].title
        return cell
    }
}

// MARK: Add Todo Button
extension HomeVC {
    static func addTodoButton() -> UIButton {
        let button = withAutoLayout(UIButton(type: .roundedRect))
        button.setTitle("Add Todo", for: .normal)
        return button
    }
    func addButtonLayout() -> [NSLayoutConstraint] {
        let layoutGuide = view.safeAreaLayoutGuide
        return [
            addTodoButton.centerXAnchor.constraint(equalTo: layoutGuide.centerXAnchor),
            addTodoButton.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: -40)
        ]
    }
    @IBAction func addTodo(button: UIButton) {
        shell.receive(.todo(.create))
    }
}
