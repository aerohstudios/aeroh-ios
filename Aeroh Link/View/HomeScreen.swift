//
//  HomeScreen.swift
//  Aeroh Link
//
//  Created by Tanishq Patidar on 13/07/23.
//

import SwiftUI

struct HomeScreen: View {
        @State private var accessToken: String = ""
        @State private var refreshToken: String = ""
        @State private var expiresIn: Int = 0
        @State private var createdAt: Int = 0
        @ObservedObject var loginManager : LoginManager
        
        var body: some View {
            VStack {
                
                Text("Access Token: \(accessToken)")
                Text("Refresh Token: \(refreshToken)")
                Text("Expires In: \(expiresIn)")
                Text("Created At: \(createdAt)")
                
                Button("Delete Keychain Values") {
                    loginManager.logout()
                    deleteKeychainValues()
                }
                .buttonStyle(.borderedProminent)
                .padding()
    
            }
            .onAppear {
                loadKeychainValues()
            }
        }
        
        private func loadKeychainValues() {
            accessToken = KeychainManager.shared.getAccessToken() ?? ""
            refreshToken = KeychainManager.shared.getRefreshToken() ?? ""
            expiresIn = KeychainManager.shared.getExpiresIn() ?? 0
            createdAt = KeychainManager.shared.getCreatedAt() ?? 0
        }
        
        private func deleteKeychainValues() {
            KeychainManager.shared.deleteValue(forKey: KeychainManager.shared.accessTokenKey)
            KeychainManager.shared.deleteValue(forKey: KeychainManager.shared.refreshTokenKey)
            KeychainManager.shared.deleteValue(forKey: KeychainManager.shared.expiresInKey)
            KeychainManager.shared.deleteValue(forKey: KeychainManager.shared.createdAtKey)
            
            // Update the UI after deleting the keychain values
            accessToken = ""
            refreshToken = ""
            expiresIn = 0
            createdAt = 0
        }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        let loginManager = LoginManager()
        HomeScreen(loginManager: loginManager)
    }
}
