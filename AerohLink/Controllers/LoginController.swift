//
//  LoginController.swift
//  AerohLink
//
//  Created by Tanishq Patidar on 06/07/23.
//

import Foundation

struct LoginController {
    func authenticate(email: String, password: String, loginManager: LoginManager, completion: @escaping (Result<Any, Error>) -> Void) {
        let scopes = "mobile"
        let timestamp = TimestampGenerator.generateTimestamp()
        let data = UserModel(email: email, password: password, firstName: nil, scopes: scopes, timestamp: timestamp, oAuthClientId: nil, signature: nil)
        let signature = SignatureController().login_signature(signData: data, key: oAuthClientSecret)

        let userRequestData = UserModel(email: email.lowercased(), password: password, firstName: nil, scopes: scopes, timestamp: timestamp, oAuthClientId: oAuthClientId, signature: signature)

        APIManager.shared.callingLoginAPI(userRequestData: userRequestData) { result in
            switch result {
            case .success:
                completion(.success(0))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
