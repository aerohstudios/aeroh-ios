//
//  UserModel.swift
//  AerohLink
//
//  Created by Tanishq Patidar on 06/07/23.
//

import Foundation

struct UserModel: Codable {

    let email: String
    let password: String
    let first_name: String?
    let scopes: String
    let timestamp: Int
    let client_id: String?
    let signature: String?

}
