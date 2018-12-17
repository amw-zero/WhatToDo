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
        var expectedState = initialState
        expectedState.paginationState = .fetching
        XCTAssertEqual(state, expectedState)
        XCTAssertEqual(effect, Effect.fetchData(.suggestedTodo(page: 0)))
    }
    func testTodosReceived() {
        let initialTodos = [Todo(title: "First Todo")]
        let initialState = TodoState(todos: initialTodos, paginationState: .fetching)
        let todos = [Todo(title: "Test Todo")]
        let message = TodoMessage.todosReceived(todos)
        let (state, effect) = todoUpdate(message: message, state: initialState)
        var expectedState = initialState
        expectedState.todos = initialTodos + todos
        expectedState.paginationState = .idle
        XCTAssertEqual(state, expectedState)
        XCTAssertNil(effect)
    }
    func testTodoPagination() {
        let initialState = TodoState(todos: [], suggestedTodoPage: 1)
        let message = TodoMessage.fetchSuggestedPage
        let (state, effect) = todoUpdate(message: message, state: initialState)
        var expectedState = initialState
        expectedState.suggestedTodoPage = 2
        expectedState.paginationState = .fetching
        XCTAssertEqual(state, expectedState)
        XCTAssertEqual(effect, Effect.fetchData(.suggestedTodo(page: 2)))
    }
    func testTodoPaginationWhenNotIdle() {
        let initialState = TodoState(paginationState: .fetching)
        let message = TodoMessage.fetchSuggestedPage
        let (state, effect) = todoUpdate(message: message, state: initialState)
        XCTAssertEqual(state, initialState)
        XCTAssertNil(effect)
    }
}
