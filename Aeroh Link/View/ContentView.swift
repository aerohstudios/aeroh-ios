//
//  ContentView.swift
//  Aeroh Link
//
//  Created by Shiv Deepak on 6/21/23.
//

import SwiftUI

struct ContentView: View {
    @State private var isLoggedIn = false
    
    var body: some View {
        Group {
            if isLoggedIn {
                HomeScreen()
            } else {
                OnboardingScreenView()
                    .onAppear {
                        // Check if access token is present in keychain
                        if KeychainManager.shared.getAccessToken() != nil {
                            print("contentView",KeychainManager.shared.getAccessToken()!)
                            // Access token exists, set isLoggedIn to true
                            isLoggedIn = true
                        } else {
                            // Access token doesn't exist, set isLoggedIn to false
                            isLoggedIn = false
                        }
                    }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

