//
//  ContentView.swift
//  ReduxPlayground
//
//  Created by nikita on 31.05.2023.
//

import SwiftUI

struct ContentView: View {
	
	@StateObject private var store = ApplicationStore { currentState, action in
		var newState = currentState
		switch action {
		case .setAccessToken(let accessToken): newState.accessToken = accessToken
		default: break
		}
		
		return newState
	} middleware: {
		LogMiddleware()
		LoginMiddleware()
	}
	
    var body: some View {
		VStack { 
			if store.state.isLoggedIn {
				HomeView()
					.environmentObject(store)	
			} else {
				LoginView()
					.environmentObject(store)
			}
		} 
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
