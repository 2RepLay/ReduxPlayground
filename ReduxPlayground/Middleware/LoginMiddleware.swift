//
//  LoginMiddleware.swift
//  ReduxPlayground
//
//  Created by nikita on 31.05.2023.
//

import Foundation

struct LoginMiddleware: Middleware {
	
	func callAsFunction(action: ApplicationAction) async -> ApplicationAction? {
		guard case let .login(username, password) = action else {
			return action
		}
		
		print("TODO: asynchronously login with \(username) and \(password)")

		return .setAccessToken("AUTHORIZED")
	}
	
}
