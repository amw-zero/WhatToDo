//
//  TodoMessage.swift
//  WhatToDoLogic
//
//  Created by Alex on 12/14/18.
//  Copyright © 2018 Alex. All rights reserved.
//

import Foundation

public enum TodoMessage {
    case create
    case suggest
}

struct TodoState: Equatable {
}

func todoUpdate(message: TodoMessage, state: TodoState) -> (TodoState, Effect?) {
    switch message {
    case .create:
        return (state, .showModal(.createTodo))
    case .suggest:
        return (state, .fetchData(.suggestedTodo))
    }
}
