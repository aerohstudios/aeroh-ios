//
//  LoginManager.swift
//  Aeroh Link
//
//  Created by Tanishq Patidar on 28/07/23.
//

import Foundation
import SwiftUI

class LoginManager: ObservableObject {
    @Published var isLoggedIn: Bool
    
    init() {
        self.isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
    }
    
    func login() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation {
                UserDefaults.standard.set(true, forKey: "isLoggedIn")
                self.isLoggedIn = true
            }
        }
    }
    func logout() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation {
                UserDefaults.standard.set(false, forKey: "isLoggedIn")
                self.isLoggedIn = false
            }
        }
    }
}
