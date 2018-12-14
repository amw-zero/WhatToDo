//
//  Message.swift
//  WhatToDoLogic
//
//  Created by Alex on 12/14/18.
//  Copyright © 2018 Alex. All rights reserved.
//

import Foundation

enum Message {
    case todo(TodoMessage)
}

struct State {
    var todoState: TodoState
}

enum View: Equatable {
    case createTodo
}

enum Effect: Equatable {
    case showModal(View)
}
