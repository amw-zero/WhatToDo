//
//  Message.swift
//  WhatToDoLogic
//
//  Created by Alex on 12/14/18.
//  Copyright © 2018 Alex. All rights reserved.
//

import Foundation

public enum Message {
    case bootstrap
    case todo(TodoMessage)
    case showModal
    case dismissModal
}

public struct State: Equatable {
    var todoState: TodoState
    public init() {
        self.todoState = TodoState()
    }
}

public enum View: Equatable {
    case home
    case createTodo
}

public enum Effect: Equatable {
    case setView(View)
    case showModal(View)
    case dismissModal
    case fetchData(RemoteData)
}

public enum RemoteData: Equatable {
    case suggestedTodo
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
