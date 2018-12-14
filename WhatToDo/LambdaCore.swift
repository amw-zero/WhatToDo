//
//  LambdaCore.swift
//  LambdaCore
//
//  Created by Alex on 12/12/18.
//  Copyright © 2018 Alex. All rights reserved.
//

import Foundation

public protocol Executor {
    func execute<State, Message, Effect>(withOrchestrator orchestrator: Orchestrator<State, Message, Effect>)
}
struct NullExecutor: Executor {
    func execute<State, Message, Effect>(
        withOrchestrator orchestrator: Orchestrator<State, Message, Effect>) {
    }
}

public protocol ExecutorProducer {
    func executorFor<Effect>(_ effect: Effect) -> Executor
}

public typealias SubscriptionId = Int

public class Orchestrator<State, Message, Effect> {
    public typealias UpdateFunc = (Message, State) -> (State, Effect?)
    public typealias SubscriptionFunc = (State) -> Void
    public typealias ExecutorFunc = (Effect) -> Executor
    public var executorFor: ExecutorFunc = { _ in return NullExecutor() }
    var state: State
    var update: UpdateFunc
    var subscriptions: [(State) -> Void] = []
    public init(state: State, update: @escaping UpdateFunc) {
        self.state = state
        self.update = update
    }
    public func receive(_ message: Message) {
        let (newState, effect) = update(message, state)
        state = newState
        subscriptions.forEach { $0(state) }
        effect.map {
            executorFor($0)
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
