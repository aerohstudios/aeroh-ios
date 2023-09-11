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
    let firstName: String?
    let scopes: String
    let timestamp: Int
    let oAuthClientId: String?
    let signature: String?

    // CodingKeys enum to specify custom keys
    private enum CodingKeys: String, CodingKey {
        case email
        case password
        case firstName = "first_name"
        case scopes
        case timestamp
        case oAuthClientId = "client_id"
        case signature
    }
}
