//
//  UserController.swift
//  AerohLink
//
//  Created by Tanishq Patidar on 04/08/23.
//

import Foundation
import SwiftUI

class UserController: ObservableObject {
    @Published var user: UserInfo = UserInfo(email: "email", firstName: "First Name", id: nil)
    @Published var error: Error?
    @Published var showErrorAlert = false
    func fetchUser(accessToken: String) {
        APIManager.shared.fetchUser(with: accessToken) { result in
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.user = user
                    UserDefaults.standard.set(user.firstName, forKey: "first_name")
                    UserDefaults.standard.set(user.email, forKey: "email")
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    withAnimation {
                        self.showErrorAlert = true
                    }
                    self.error = error
                }
            }
        }
    }
}
