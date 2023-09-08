//
//  SignupController.swift
//  AerohLink
//
//  Created by Tanishq Patidar on 10/07/23.
//

import Foundation

struct SignupController {
    func authenticate(firstName: String, email: String, password: String, completion: @escaping (Result<Any, Error>) -> Void) {
        let scopes = "mobile"
        let timestamp = TimestampGenerator.generateTimestamp()
        let data = UserModel(email: email, password: password, firstName: firstName, scopes: scopes, timestamp: timestamp, oAuthClientId: nil, signature: nil)
        let signature = SignatureController().signup_signature(signData: data, key: oAuthClientSecret)
        let userRequestData = UserModel(email: email.lowercased(), password: password, firstName: firstName, scopes: scopes, timestamp: timestamp, oAuthClientId: oAuthClientId, signature: signature)
        APIManager.shared.callingSignupAPI(userRequestData: userRequestData) { result in
            switch result {
            case .success:
                completion(.success(0))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
