//
//  AppDelegate.swift
//  WhatToDo
//
//  Created by Alex on 12/12/18.
//  Copyright © 2018 Alex. All rights reserved.
//

import UIKit
import WhatToDoLogic

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        orchestrator.receive(.todo(.create))
        return true
    }
}
