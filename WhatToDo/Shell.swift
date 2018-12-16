//
//  World.swift
//  WhatToDo
//
//  Created by Alex on 12/14/18.
//  Copyright © 2018 Alex. All rights reserved.
//

import Foundation
import WhatToDoLogic

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

struct ShowModalExecutor: Executor {
    let window: UIWindow?
    init(withWindow window: UIWindow?) {
        self.window = window
    }
    func execute<State, Message, Effect>(withOrchestrator orchestrator: Orchestrator<State, Message, Effect>) {
        let storyboard = UIStoryboard(name: "HomeVC", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ModalVC")
        window?.rootViewController?.present(vc, animated: true, completion: nil)
    }
}
    
struct DismissModalExecutor: Executor {
    let window: UIWindow?
    init(withWindow window: UIWindow?) {
        self.window = window
    }
    func execute<State, Message, Effect>(withOrchestrator orchestrator: Orchestrator<State, Message, Effect>) {
        window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
}

struct FetchDataExecutor: Executor {
    let remoteData: RemoteData
    func execute<State, Msg, Effect>(withOrchestrator orchestrator: Orchestrator<State, Msg, Effect>) {
        // TODO: orchestrator.receive(.fetchingData)
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {
            let message: Message = self.remoteData.parser.parse(data: nil, response: nil, error: nil)
            // How can I get rid of this cast?
            orchestrator.receive(message as! Msg)
        }
    }
}

func makeExecutorFactory(window: UIWindow?) -> (Effect) -> Executor {
    return { effect in
        switch effect {
        case .setView:
            return SetViewExecutor(withWindow: window)
        case .dismissModal:
            return DismissModalExecutor(withWindow: window)
        case .showModal:
            return ShowModalExecutor(withWindow: window)
        case let .fetchData(remoteData):
            return FetchDataExecutor(remoteData: remoteData)
        }
    }
}

let orchestrator = Orchestrator(state: State(), update: update)
