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
    case fetchSuggestedPage
    case todosReceived([Todo])
}

public struct TodoState: Equatable {
    public var todos: [Todo]
    public var suggestedTodoPage: Int
    public var paginationState: PaginationState
    public init(todos: [Todo] = [], suggestedTodoPage: Int = 0, paginationState: PaginationState = .idle) {
        self.todos = todos
        self.suggestedTodoPage = suggestedTodoPage
        self.paginationState = paginationState
    }
}

func todoUpdate(message: TodoMessage, state: TodoState) -> (TodoState, Effect?) {
    switch message {
    case .create:
        return (state, .showModal(.createTodo))
    case .suggest:
        var newState = state
        newState.paginationState = .fetching
        return (newState, .fetchData(.suggestedTodo(page: 0)))
    case let .todosReceived(todos):
        var newState = state
        newState.todos = state.todos + todos
        return (newState, nil)
    case .fetchSuggestedPage where .idle == state.paginationState:
        let nextTodosPage = state.suggestedTodoPage + 1
        var newState = state
        newState.suggestedTodoPage = nextTodosPage
        newState.paginationState = .fetching
        return (newState, .fetchData(.suggestedTodo(page: nextTodosPage)))
    default:
        return (state, nil)
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
