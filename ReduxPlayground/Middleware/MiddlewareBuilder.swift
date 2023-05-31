//
//  MiddlewareBuilder.swift
//  ReduxPlayground
//
//  Created by nikita on 31.05.2023.
//

import Foundation

@resultBuilder
struct MiddlewareBuilder<Action> {
	
	static func buildArray(
		_ components: [AnyMiddleware<Action>]
	) -> AnyMiddleware<Action> {
		MiddlewarePipeline(components.map({ $0.eraseToAnyMiddleware() }))
			.eraseToAnyMiddleware()
	}
	
	static func buildBlock(
		_ components: AnyMiddleware<Action>...
	) -> MiddlewarePipeline<Action> {
		.init(components)
	}
	
	static func buildExpression<M: Middleware>(
		_ expression: M
	) -> AnyMiddleware<Action> where M.Action == Action {
		expression.eraseToAnyMiddleware()
	}
	
	static func buildOptional(
		_ component: AnyMiddleware<Action>?
	) -> AnyMiddleware<Action> {
		guard let component = component else {
			return EchoMiddleware<Action>().eraseToAnyMiddleware()
		}
		
		return component.eraseToAnyMiddleware()
	}
	
	static func buildFinalResult<M: Middleware>(
		_ component: M
	) -> AnyMiddleware<Action> where M.Action == Action {
		component.eraseToAnyMiddleware()
	}

	static func buildEither<M: Middleware>(
		first component: M
	) -> AnyMiddleware<Action> where M.Action == Action {
		component.eraseToAnyMiddleware()
	}
	
	static func buildEither<M: Middleware>(
		second component: M
	) -> AnyMiddleware<Action> where M.Action == Action {
		component.eraseToAnyMiddleware()
	}
	
}
