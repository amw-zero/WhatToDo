//
//  CreateTodoLogicTests.swift
//  WhatToDoLogicTests
//
//  Created by Alex on 12/14/18.
//  Copyright © 2018 Alex. All rights reserved.
//

import XCTest
@testable import WhatToDoLogic

class TodoLogicTests: XCTestCase {
    func testTodoCreationInitiation() {
        let initialState = TodoState()
        let message = TodoMessage.create
        let (state, effect) = todoUpdate(message: message, state: initialState)
        XCTAssertEqual(state, initialState)
        XCTAssertEqual(effect, Effect.showModal(.createTodo))
    }
    func testDisplayingSuggestedTodos() {
        let initialState = TodoState()
        let message = TodoMessage.suggest
        let (state, effect) = todoUpdate(message: message, state: initialState)
        XCTAssertEqual(state, initialState)
        XCTAssertEqual(effect, Effect.fetchData(.suggestedTodo(page: 0)))
    }
    func testTodosReceived() {
        let initialState = TodoState()
        let todos = [Todo(title: "Test Todo")]
        let message = TodoMessage.todosReceived(todos)
        let (state, effect) = todoUpdate(message: message, state: initialState)
        XCTAssertEqual(state, TodoState(todos: todos))
        XCTAssertNil(effect)
    }
}
