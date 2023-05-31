//
//  LogMiddleware.swift
//  ReduxPlayground
//
//  Created by nikita on 31.05.2023.
//

import Foundation

struct LogMiddleware<Action>: Middleware {
	func callAsFunction(action: Action) async -> Action? {
		print("\(action)")
		return action
	}
}
