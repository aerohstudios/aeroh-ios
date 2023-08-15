//
//  UserController.swift
//  Aeroh Link
//
//  Created by Tanishq Patidar on 04/08/23.
//

import Foundation

class UserController: ObservableObject {
    @Published var users: [UserInfo] = []
    @Published var showAlert = false
    @Published var alertMessage = ""
    
    func fetchUsers(accessToken: String) {
        APIManager.shared.fetchUsers(with: accessToken, errorCallback: { errorMessage in
            DispatchQueue.main.async {
                self.showAlert = true
                self.alertMessage = errorMessage
            }
        }, completion: { users in
            DispatchQueue.main.async {
                self.users = [users]
            }
        })
    }
}



