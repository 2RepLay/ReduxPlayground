//
//  AnyMiddleware.swift
//  ReduxPlayground
//
//  Created by nikita on 31.05.2023.
//

import Foundation

struct AnyMiddleware<Action>: Middleware {
	
	private let wrappedMiddleware: (Action) async -> Action? 
	
	init<M: Middleware>(_ middleware: M) where M.Action == Action {
		self.wrappedMiddleware = middleware.callAsFunction(action:)
	}
	
	func callAsFunction(action: Action) async -> Action? {
		return await wrappedMiddleware(action)
	}
	
} 

extension Middleware {
	func eraseToAnyMiddleware() -> AnyMiddleware<Action> {
		return self as? AnyMiddleware<Action> ?? AnyMiddleware(self)
	}
}
