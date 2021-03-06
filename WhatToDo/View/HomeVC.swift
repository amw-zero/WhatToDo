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
    let tableView = makeTableView()
    let addTodoButton = HomeVC.addTodoButton()
}
    
// MARK: UIViewController Lifecycle Methods
extension HomeVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Style.colorBlue
        styleTableView(tableView)
        tableView.register(CategoryTVC.self, forCellReuseIdentifier: "CategoryTVC")
        tableView.dataSource = self
        addTodoButton.addTarget(self, action: #selector(addTodo(button:)), for: .touchUpInside)
        setupView()
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

extension HomeVC {
    func setupView() {
        view.subviews {[
            tableView,
            addTodoButton
        ]}
        NSLayoutConstraint.activate(
            tableViewLayout() + addButtonLayout()
        )
    }
    func render(state: State) {
        todos = state.todoState.todos
        tableView.reloadData()
    }
}

extension HomeVC {
    static func makeTableView() -> UITableView {
        let tableView = withAutoLayout(UITableView(frame: .zero))
        tableView.backgroundColor = .clear
        return tableView
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

// MARK: UITableViewDataSource
extension HomeVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row > (todos.count - paginationThreshold)   {
            shell.receive(.todo(.fetchSuggestedPage))
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTVC", for: indexPath) as! CategoryTVC
        cell.titleLabel.text = todos[indexPath.row].title
        cell.boldDescriptionLabel.text = "This is a Category"
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
    @objc func addTodo(button: UIButton) {
        shell.receive(.todo(.create))
    }
}
