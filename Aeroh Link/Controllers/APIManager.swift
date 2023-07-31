//
//  APIManager.swift
//  Aeroh Link
//
//  Created by Tanishq Patidar on 06/07/23.
//

import Foundation
import Alamofire

class APIManager {
    static let shared = APIManager()
    
    // Define a callback closure to handle errors
    typealias ErrorCallback = (String) -> Void
    
    //Define a callback closure for success
    typealias SuccessCallback = () -> Void
    
    // Check internet connectivity before making API requests
    private func isInternetConnected() -> Bool {
        let reachabilityManager = NetworkReachabilityManager()
        return reachabilityManager?.isReachable ?? false
    }
    
    func callingLoginAPI(userRequestData: UserModel, errorCallback: @escaping ErrorCallback, successCallback: @escaping SuccessCallback) {
        guard isInternetConnected() else {
            let errorMessage = "No internet connection"
            errorCallback(errorMessage)
            return
        }
        let headers: HTTPHeaders = [
            .contentType("application/json")
        ]
        
        AF.request(login_url, method: .post, parameters: userRequestData, encoder: JSONParameterEncoder.default, headers: headers).response { response in
            switch response.result {
            case .success(let data):
                do {
                    if let jsonData = data, let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                        if let errors = json["errors"] as? [String], errors.count > 0 {
                            let errorMessage = errors[0]
                            errorCallback(errorMessage)                        } else if let responseData = json["data"] as? [String: Any] {
                                if let accessToken = responseData["access_token"] as? String,
                                   let refreshToken = responseData["refresh_token"] as? String,
                                   let expiresIn = responseData["expires_in"] as? Int,
                                   let createdAt = responseData["created_at"] as? Int {
                                    KeychainManager.shared.saveCredentials(accessToken: accessToken, refreshToken: refreshToken, expiresIn: expiresIn, createdAt: createdAt)
                                    successCallback()
                                }
                            }
                    }
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                errorCallback(error.localizedDescription)
            }
        }
    }
    
    func callingSignupAPI(userRequestData: UserModel, errorCallback: @escaping ErrorCallback, successCallback: @escaping SuccessCallback) {
        let headers: HTTPHeaders = [
            .contentType("application/json")
        ]
        
        AF.request(signup_url, method: .post, parameters: userRequestData, encoder: JSONParameterEncoder.default, headers: headers).response { response in
            switch response.result {
            case .success(let data):
                do {
                    if let jsonData = data, let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                        if let errors = json["errors"] as? [String], errors.count > 0 {
                            let errorMessage = errors[0]
                            errorCallback(errorMessage)
                        } else if let responseData = json["data"] as? [String: Any] {
                            if let accessToken = responseData["access_token"] as? String,
                               let refreshToken = responseData["refresh_token"] as? String,
                               let expiresIn = responseData["expires_in"] as? Int,
                               let createdAt = responseData["created_at"] as? Int {
                                KeychainManager.shared.saveCredentials(accessToken: accessToken, refreshToken: refreshToken, expiresIn: expiresIn, createdAt: createdAt)
                                successCallback()
                            }
                        }
                    }
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                errorCallback(error.localizedDescription)
            }
        }
    }
}
