//
//  LoginView.swift
//  ReduxPlayground
//
//  Created by nikita on 31.05.2023.
//

import SwiftUI

struct LoginView: View {
	
	@EnvironmentObject private var store: ApplicationStore
	
	@State private var username: String = ""
	@State private var password: String = ""
	
    var body: some View {
		VStack {
			TextField("Username", text: $username)
			SecureField("Password", text: $password)
			
			Button("Log In") {
				let username = self.username
				let password = self.password
				Task {
					await store.dispatch(.login(username, password))
				}
			}
		}
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
