//
//  Middleware.swift
//  ReduxPlayground
//
//  Created by nikita on 31.05.2023.
//

import Foundation

protocol Middleware {
	associatedtype Action
	
	func callAsFunction(action: Action) async -> Action? 
}
