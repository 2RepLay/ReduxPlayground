//
//  MiddlewarePipeline.swift
//  ReduxPlayground
//
//  Created by nikita on 31.05.2023.
//

import Foundation

struct MiddlewarePipeline<Action>: Middleware {
	private let middleware: [AnyMiddleware<Action>]
	
	init(_ middleware: AnyMiddleware<Action>...) {
		self.middleware = middleware
	}
	
	init(_ middleware: [AnyMiddleware<Action>]) {
		self.middleware = middleware
	}
	
	func callAsFunction(action: Action) async -> Action? {
		var currentAction: Action = action
		for m in middleware {
			guard let newAction = await m(action: currentAction) else {
				return nil
			}
			
			currentAction = newAction
		}
		return currentAction
	}
}
