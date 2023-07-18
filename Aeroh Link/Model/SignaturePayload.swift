//
//  DataModel.swift
//  Aeroh Link
//
//  Created by Tanishq Patidar on 07/07/23.
//

import Foundation

struct LoginSignaturePayload{
    let email: String
    let password: String
    let scopes: String
    let timestamp: Int
}

struct SignupSignaturePayload{
    let email: String
    let password: String
    let first_name: String
    let scopes: String
    let timestamp: Int
}
