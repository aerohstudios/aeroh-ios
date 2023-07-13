//
//  UserSignupModel.swift
//  Aeroh Link
//
//  Created by Tanishq Patidar on 10/07/23.
//

import Foundation

struct UserSignupModel: Codable {
    
    let email: String
    let password: String
    let first_name: String
    let scopes: String
    let timestamp: Int
    let client_id: String
    let signature: String
    
}
