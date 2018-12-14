//
//  RootTests.swift
//  WhatToDoLogicTests
//
//  Created by Alex on 12/14/18.
//  Copyright © 2018 Alex. All rights reserved.
//

import XCTest
@testable import WhatToDoLogic

class RootTests: XCTestCase {
    func testTodoMessages() {
        let message = Message.todo(.create)
        let initialState = State()
        let (state, effect) = update(message: message, state: initialState)
        XCTAssertEqual(state, initialState)
        XCTAssertEqual(effect, .showModal(.createTodo))
    }
    func testBootstrap() {
        let message = Message.bootstrap
        let initialState = State()
        let (state, effect) = update(message: message, state: initialState)
        XCTAssertEqual(state, initialState)
        XCTAssertEqual(effect, .setView(.home))
    }
}
