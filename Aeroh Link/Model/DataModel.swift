//
//  DataModel.swift
//  Aeroh Link
//
//  Created by Tanishq Patidar on 07/07/23.
//

import Foundation

struct signData_login{
    let email: String
    let password: String
    let scopes: String
    let timestamp: Int
}

struct signData_signup{
    let email: String
    let password: String
    let first_name: String
    let scopes: String
    let timestamp: Int
}
