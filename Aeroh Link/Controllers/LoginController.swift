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
        let data = LoginSignaturePayload(email: email, password: password, scopes: scopes, timestamp: timestamp)
        let signature = SignatureController().login_signature(signData: data, key: secret)
        
        let userRequestData = UserLoginPayload(email: email.lowercased(), password: password, scopes: scopes, timestamp: timestamp, client_id: client_id, signature: signature)
        
        APIManager.shared.callingLoginAPI(userRequestData: userRequestData) { errorMessage in
            errorCallback(errorMessage)
        }
    }
}
