//
//  LoginModel.swift
//  Aeroh Link
//
//  Created by Tanishq Patidar on 06/07/23.
//

import Foundation

struct UserLoginModel: Codable {
    
    let email: String
    let password: String
    let scopes: String
    let timestamp: Int
    let client_id: String
    let signature: String
    
}
