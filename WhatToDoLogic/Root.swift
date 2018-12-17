//
//  Message.swift
//  WhatToDoLogic
//
//  Created by Alex on 12/14/18.
//  Copyright © 2018 Alex. All rights reserved.
//

import Foundation

public struct State: Equatable {
    public var todoState: TodoState
    public init() {
        self.todoState = TodoState()
    }
}

public enum Message {
    case bootstrap
    case todo(TodoMessage)
    case showModal
    case dismissModal
}

public enum Effect: Equatable {
    case setView(View)
    case showModal(View)
    case dismissModal
    case fetchData(RemoteData)
}

public enum View: Equatable {
    case home
    case createTodo
}

public protocol Parser {
    func parse(data: Data?, response: URLResponse?, error: Error?) -> Message
}

public enum RemoteData: Equatable {
    case suggestedTodo(page: Int)
    public var parser: Parser {
        switch self {
        case .suggestedTodo:
            return TodoParser()
        }
    }
}

public func update(message: Message, state: State) -> (State, Effect?) {
    var newState = state
    switch message {
    case let .todo(todoMessage):
        let (todoState, effect) = todoUpdate(message: todoMessage, state: state.todoState)
        newState.todoState = todoState
        return (newState, effect)
    case .bootstrap:
        return (state, .setView(.home))
    case .showModal:
        return (state, .showModal(.home))
    case .dismissModal:
        return (state, .dismissModal)
    }
}
