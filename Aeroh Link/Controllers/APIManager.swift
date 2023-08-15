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
    
    var isValid: Bool {
        return isAccessTokenValid()
    }
    // Check internet connectivity before making API requests
    private func isInternetConnected() -> Bool {
        let reachabilityManager = NetworkReachabilityManager()
        return reachabilityManager?.isReachable ?? false
    }
    
    private func isAccessTokenValid() -> Bool {
        print(35, "api manger")
        let tokenGenerationDate = KeychainManager.shared.getCreatedAt() // Assuming it returns TimeInterval or Unix timestamp
        let expiresIn = KeychainManager.shared.getExpiresIn()
        
        let currentDate = Date()
        let createdDateNewType = Date(timeIntervalSince1970: TimeInterval(tokenGenerationDate ?? 0))
        let expirationDate = createdDateNewType.addingTimeInterval(TimeInterval(expiresIn ?? 0))
        
        return expirationDate > currentDate
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
                if error.localizedDescription != "" {
                    errorCallback("Cannot Connect to Server")
                }
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
                if error.localizedDescription != "" {
                    errorCallback("Cannot Connect to Server")
                }
            }
        }
    }
    
    func fetchUsers(with accessToken: String, errorCallback: @escaping ErrorCallback, completion: @escaping (UserInfo) -> Void) {
        guard isInternetConnected() else {
            let errorMessage = "No internet connection"
            errorCallback(errorMessage)
            return
        }
        
        if isValid {
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)"
        ]
        
        AF.request("\(base_url)/api/v1/users", method: .get, headers: headers).responseJSON { response in
            switch response.result {
                
            case .success(let data):
                if let json = data as? [String: Any],
                   let dataArray = json["data"] as? [[String: Any]],
                   let firstUser = dataArray.first,
                   let attributes = firstUser["attributes"] as? [String: Any],
                   let email = attributes["email"] as? String,
                   let firstName = attributes["first-name"] as? String{
                    let user = UserInfo(email: email, first_name: firstName, id: nil)
                    completion(user)
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchDevices(with accessToken: String, errorCallback: @escaping ErrorCallback, completion: @escaping ([DeviceModel]) -> Void) {
        guard isInternetConnected() else {
            let errorMessage = "No internet connection"
            errorCallback(errorMessage)
            return
        }
        
        if isValid {
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)"
        ]
        
        AF.request("\(base_url)/api/v1/devices", method: .get, headers: headers).responseJSON { response in
            switch response.result {
            case .success(let data):
                if let json = data as? [String: Any],
                   let dataArray = json["data"] as? [[String: Any]] {
                    var devices: [DeviceModel] = []
                    for deviceData in dataArray {
                        if let attributes = deviceData["attributes"] as? [String: Any],
                           let name = attributes["name"] as? String {
                            let device = DeviceModel(name: name)
                            devices.append(device)
                        }
                    }
                    completion(devices)
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
