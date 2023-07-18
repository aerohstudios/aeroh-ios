//
//  SignupController.swift
//  Aeroh Link
//
//  Created by Tanishq Patidar on 10/07/23.
//

import Foundation

struct SignupController {
    func authenticate(first_name: String, email: String, password: String, errorCallback: @escaping (String) -> Void) {
        let scopes = "mobile"
        let timestamp = TimestampGenerator.generateTimestamp()
        let data = SignupSignaturePayload(email: email, password: password, first_name: first_name, scopes: scopes, timestamp: timestamp)
        let signature = SignatureController().signup_signature(signData: data, key: secret)
        let userRequestData = UserSignupPayload(email: email.lowercased(), password: password, first_name: first_name, scopes: scopes, timestamp: timestamp, client_id: client_id, signature: signature)
        APIManager.shared.callingSignupAPI(userRequestData: userRequestData) { errorMessage in
            errorCallback(errorMessage)
        }
    }
}
