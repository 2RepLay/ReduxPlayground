//
//  Store.swift
//  ReduxPlayground
//
//  Created by nikita on 31.05.2023.
//

import Combine

protocol SomeState {
	init()
}

actor Store<S: SomeState, Action>: ObservableObject {
	
	typealias Reducer = (S, Action) -> S
	
	@MainActor @Published private(set) var state: S = .init()
	
	private let middleware: AnyMiddleware<Action>
	private let reducer: Reducer
	
	init<M: Middleware>(
		reducer: @escaping Reducer, 
		@MiddlewareBuilder<Action> middleware: () -> M
	) where M.Action == Action {
		self.reducer = reducer
		self.middleware = middleware().eraseToAnyMiddleware()
	}
	
	init(reducer: @escaping Reducer) {
		self.init(
			reducer: reducer, 
			middleware: { 
				EchoMiddleware<Action>()
			}
		)
	}
	
	func dispatch(_ action: Action) async {
		guard let newAction = await middleware(action: action) else {
			return
		}
		
		await MainActor.run {
			let currentState = state
			let newState = reducer(currentState, newAction)
			
			state = newState	
		}
	}
	
}

extension Store {
	
	func dispatch<S: AsyncSequence>(
		sequence: S
	) async throws where S.Element == Action {
		for try await action in sequence {
			await dispatch(action)
		}
	}
	
}
