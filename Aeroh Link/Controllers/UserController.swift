//
//  UserController.swift
//  Aeroh Link
//
//  Created by Tanishq Patidar on 04/08/23.
//

import Foundation

class UserController: ObservableObject {
    @Published var users: [UserInfo] = []
    
    func fetchUsers(accessToken: String, completion: @escaping ([UserInfo]) -> Void) {
        APIManager.shared.fetchUsers(with: accessToken, errorCallback: { errorMessage in
            print(errorMessage) // Handle the error
            completion([]) // Return an empty array in case of an error
        }, completion: { users in
            DispatchQueue.main.async {
                completion([users])
            }
        })
    }
}



