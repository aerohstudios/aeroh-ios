//
//  Constant.swift
//  Aeroh Link
//
//  Created by Tanishq Patidar on 06/07/23.
//

import Foundation

let base_url = "https://cloud.aeroh.org"
let login_url = "\(base_url)/users/sign_in"
let signup_url = "\(base_url)/users"
// android location for email and password regex: app/src/utils/TextValidators.java
let emailRegex = #"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])"#
let passwordRegex = "^(?=.*\\d)(?=.*[a-zA-Z]).{6,}$"
let forgotPassword_url = "\(base_url)/users/password/new"
