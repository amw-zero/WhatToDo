//
//  World.swift
//  WhatToDo
//
//  Created by Alex on 12/14/18.
//  Copyright © 2018 Alex. All rights reserved.
//

import Foundation
import WhatToDoLogic

struct DummyExecutor: Executor {
    func execute<State, Message, Effect>(withOrchestrator orchestrator: Orchestrator<State, Message, Effect>) {
    }
}

struct SetViewExecutor: Executor {
    let window: UIWindow?
    init(withWindow window: UIWindow?) {
        self.window = window
    }
    func execute<State, Message, Effect>(withOrchestrator orchestrator: Orchestrator<State, Message, Effect>) {
        let storyboard = UIStoryboard(name: "HomeVC", bundle: nil)
        window?.rootViewController = storyboard.instantiateInitialViewController()!
        window?.makeKeyAndVisible()
    }
}

func makeExecutorFactory(window: UIWindow?) -> (Effect) -> Executor {
    return { effect in
        switch effect {
        case .setView:
            return SetViewExecutor(withWindow: window)
        default:
            return DummyExecutor()
        }
    }
}

let orchestrator: Orchestrator<State, Message, Effect>
    = Orchestrator(state: State(), update: update)
