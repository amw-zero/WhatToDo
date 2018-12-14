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

struct ExecutorFactory: ExecutorProducer {
    func executorFor<Effect>(_ effect: Effect) -> Executor {
        return DummyExecutor()
    }
}
let orchestrator = Orchestrator(state: State(), executorFactory: ExecutorFactory(), update: update)
