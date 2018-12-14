//
//  LambdaCore.swift
//  LambdaCore
//
//  Created by Alex on 12/12/18.
//  Copyright © 2018 Alex. All rights reserved.
//

import Foundation

public protocol Executor {
    func execute<State, Action, Effect>(withOrchestrator orchestrator: Orchestrator<State, Action, Effect>)
}

public protocol ExecutorProducer {
    func executorFor<Effect>(_ effect: Effect) -> Executor
}

public typealias SubscriptionId = Int

public class Orchestrator<State, Action, Effect> {
    public typealias UpdateFunc = (Action, State) -> (State, Effect?)
    public typealias SubscriptionFunc = (State) -> Void
    var state: State
    var update: UpdateFunc
    var subscriptions: [(State) -> Void] = []
    public let executorFactory: ExecutorProducer
    public init(state: State, executorFactory: ExecutorProducer, update: @escaping UpdateFunc) {
        self.state = state
        self.executorFactory = executorFactory
        self.update = update
    }
    public func receive(_ action: Action) {
        let (newState, effect) = update(action, state)
        state = newState
        subscriptions.forEach { $0(state) }
        effect.map {
            executorFactory
                .executorFor($0)
                .execute(withOrchestrator: self)
        }
    }
    public func subscribe(subscription: @escaping SubscriptionFunc) -> SubscriptionId {
        subscriptions.append(subscription)
        subscription(state)
        return subscriptions.count - 1
    }
    public func unsubscribe(subscriptionId: SubscriptionId) {
        _ = subscriptions.remove(at: subscriptionId)
    }
}

