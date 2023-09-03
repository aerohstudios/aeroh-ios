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

    func fetchUser(accessToken: String) {
        APIManager.shared.fetchUser(with: accessToken) { result in
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.user = user
                    UserDefaults.standard.set(user.first_name, forKey: "first_name")
                    UserDefaults.standard.set(user.email, forKey: "email")
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showAlert = true
                    self.alertMessage = error.localizedDescription
                }
            }
        }
    }
}



