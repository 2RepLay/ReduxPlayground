//
//  ApplicationState.swift
//  ReduxPlayground
//
//  Created by nikita on 31.05.2023.
//

import Foundation

struct ApplicationState: SomeState {
	var accessToken: String?
	
	var isLoggedIn: Bool {
		return accessToken != nil
	}
}
