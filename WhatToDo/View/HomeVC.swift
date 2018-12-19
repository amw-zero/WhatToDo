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
    @IBOutlet weak var tableView: UITableView!
    func render(state: State) {
        todos = state.todoState.todos
        tableView.reloadData()
    }
}
    
// MARK: UIViewController Lifecycle Methods
extension HomeVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        styleTableView(tableView)
        tableView.register(TodoTVC.self, forCellReuseIdentifier: "TodoTVC")
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

// MARK: IBActions
extension HomeVC {
    @IBAction func addTodo(button: UIButton) {
        shell.receive(.todo(.create))
    }
}
