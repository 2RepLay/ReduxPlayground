//
//  EchoMiddleware.swift
//  ReduxPlayground
//
//  Created by nikita on 31.05.2023.
//

import Foundation

struct EchoMiddleware<Action>: Middleware {
	func callAsFunction(action: Action) async -> Action? {
		return action
	}
}
