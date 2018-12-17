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
    public func copy(
        todos: [Todo]? = nil,
        suggestedTodoPage: Int? = nil,
        paginationState: PaginationState? = nil
    ) -> TodoState {
        var copy = self
        copy.todos = todos ?? self.todos
        copy.suggestedTodoPage = suggestedTodoPage ?? self.suggestedTodoPage
        copy.paginationState = paginationState ?? self.paginationState
        return copy
    }
}

func todoUpdate(message: TodoMessage, state: TodoState) -> (TodoState, Effect?) {
    switch message {
    case .create:
        return (state, .showModal(.createTodo))
    case let .todosReceived(todos):
        return (
            state.copy(todos: state.todos + todos, paginationState: .idle),
            nil
        )
    case .fetchSuggestedPage where .idle == state.paginationState:
        return (
            state.copy(
                suggestedTodoPage: state.suggestedTodoPage + 1,
                paginationState: .fetching),
            .fetchData(.suggestedTodo(page: state.suggestedTodoPage))
        )
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
