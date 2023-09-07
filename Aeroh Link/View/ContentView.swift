//
//  ContentView.swift
//  Aeroh Link
//
//  Created by Shiv Deepak on 6/21/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var loginManager = LoginManager()

    var body: some View {
        if loginManager.isLoggedIn {
            HomeScreen(loginManager: loginManager)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .transition(.move(edge: .leading))
        } else {
            OnboardingScreenView(loginManager: loginManager)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .transition(.move(edge: .leading))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
