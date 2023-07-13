//
//  LoginController.swift
//  Aeroh Link
//
//  Created by Tanishq Patidar on 06/07/23.
//

import Foundation

struct LoginController {
    func authenticate(email: String, password: String, errorCallback: @escaping (String) -> Void) {
        let scopes = "mobile"
        let timestamp = TimestampGenerator.generateTimestamp()
        let data = signData_login(email: email, password: password, scopes: scopes, timestamp: timestamp)
        let signature = SignatureController().hmacSha256_login(signData: data, key: secret)
        
        let userRequestData = UserLoginModel(email: email.lowercased(), password: password, scopes: scopes, timestamp: timestamp, client_id: client_id, signature: signature)
        
        APIManager.shared.callingLoginAPI(userRequestData: userRequestData) { errorMessage in
            errorCallback(errorMessage)
        }
    }
}
