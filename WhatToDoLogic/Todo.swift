//
//  TodoMessage.swift
//  WhatToDoLogic
//
//  Created by Alex on 12/14/18.
//  Copyright © 2018 Alex. All rights reserved.
//

import Foundation

public struct Todo: Equatable {
    public let title: String
    public init(title: String) {
        self.title = title
    }
}

public enum TodoMessage {
    case create
    case suggest
    case todosReceived([Todo])
}

public struct TodoState: Equatable {
    public var todos: [Todo] = [Todo]()
}

func todoUpdate(message: TodoMessage, state: TodoState) -> (TodoState, Effect?) {
    switch message {
    case .create:
        return (state, .showModal(.createTodo))
    case .suggest:
        return (state, .fetchData(.suggestedTodo))
    case let .todosReceived(todos):
        var newState = state
        newState.todos = todos
        return (newState, nil)
    }
}

struct TodoParser: Parser {
    func parse(data: Data?, response: URLResponse?, error: Error?) -> Message {
        let todos = [
            Todo(title: "Fake Todo"),
            Todo(title: "Fake Todo 2"),
            Todo(title: "Fake Todo 3"),
            Todo(title: "Fake Todo 4"),
            Todo(title: "Fake Todo 5"),
        ]
        return .todo(.todosReceived(todos))
    }
}
