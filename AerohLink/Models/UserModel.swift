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

}
