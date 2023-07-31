//
//  LoginManager.swift
//  Aeroh Link
//
//  Created by Tanishq Patidar on 28/07/23.
//

import Foundation
import SwiftUI

class LoginManager : ObservableObject {
    @Published var isLoggedIn = false
    
    func login() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation {
                self.isLoggedIn = true
            }
        }
    }
    func logout() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation {
                self.isLoggedIn = false
            }
        }
    }
}
