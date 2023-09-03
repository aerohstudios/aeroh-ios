//
//  UserController.swift
//  Aeroh Link
//
//  Created by Tanishq Patidar on 04/08/23.
//

import Foundation

class UserController: ObservableObject {
    @Published var user: UserInfo = UserInfo(email: "email", first_name: "First Name", id: nil);
    @Published var showAlert = false
    @Published var alertMessage = ""

    func fetchUsers(accessToken: String) {
        APIManager.shared.fetchUsers(with: accessToken, errorCallback: { errorMessage in
            DispatchQueue.main.async {
                self.showAlert = true
                self.alertMessage = errorMessage
            }
        }, completion: { user in
            DispatchQueue.main.async {
                self.user = user
                UserDefaults.standard.set(user.first_name, forKey: "first_name")
                UserDefaults.standard.set(user.email, forKey: "email")
            }
        })
    }
}



