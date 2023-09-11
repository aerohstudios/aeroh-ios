//
//  APIManager.swift
//  AerohLink
//
//  Created by Tanishq Patidar on 06/07/23.
//

import Foundation
import Alamofire

class APIManager {
    static let shared = APIManager()

    var isValid: Bool {
        return isAccessTokenValid()
    }
    // Check internet connectivity before making API requests
    private func isInternetConnected() -> Bool {
        let reachabilityManager = NetworkReachabilityManager()
        return reachabilityManager?.isReachable ?? false
    }

    private func isAccessTokenValid() -> Bool {
        let tokenGenerationDate = KeychainManager.shared.getCreatedAt() // Assuming it returns TimeInterval or Unix timestamp
        let expiresIn = KeychainManager.shared.getExpiresIn()

        let currentDate = Date()
        let createdDateNewType = Date(timeIntervalSince1970: TimeInterval(tokenGenerationDate ?? 0))
        let expirationDate = createdDateNewType.addingTimeInterval(TimeInterval(expiresIn ?? 0))

        return expirationDate > currentDate
    }

    func callingLoginAPI(userRequestData: UserModel, completion: @escaping (Result<Any, Error>) -> Void) {
        guard isInternetConnected() else {
            completion(.failure(APIError.noInternetConnectionError))
            return
        }
        let headers: HTTPHeaders = [
            .contentType("application/json")
        ]

        AF.request(loginUrl, method: .post, parameters: userRequestData, encoder: JSONParameterEncoder.default, headers: headers).response { response in
            switch response.result {
            case .success(let data):
                do {
                    if let jsonData = data, let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                        if let errors = json["errors"] as? [String], errors.count > 0 {
                            let errorMessage = errors[0]
                            completion(.failure(APIError.customError(errorMessage)))
                        } else if let responseData = json["data"] as? [String: Any] {
                                if let accessToken = responseData["access_token"] as? String,
                                   let refreshToken = responseData["refresh_token"] as? String,
                                   let expiresIn = responseData["expires_in"] as? Int,
                                   let createdAt = responseData["created_at"] as? Int {
                                    KeychainManager.shared.saveCredentials(accessToken: accessToken, refreshToken: refreshToken, expiresIn: expiresIn, createdAt: createdAt)
                                    completion(.success(0))
                                }
                            }
                    }
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                if error.localizedDescription != "" {
                    completion(.failure(APIError.serverNotReachableError))
                } else {
                    completion(.failure(error))
                }
            }
        }
    }

    func callingSignupAPI(userRequestData: UserModel, completion: @escaping (Result<Any, Error>) -> Void) {
        guard isInternetConnected() else {
            completion(.failure(APIError.noInternetConnectionError))
            return
        }
        let headers: HTTPHeaders = [
            .contentType("application/json")
        ]

        AF.request(signupUrl, method: .post, parameters: userRequestData, encoder: JSONParameterEncoder.default, headers: headers).response { response in
            switch response.result {
            case .success(let data):
                do {
                    if let jsonData = data, let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                        if let errors = json["errors"] as? [String], errors.count > 0 {
                            let errorMessage = errors[0]
                            completion(.failure(APIError.customError(errorMessage)))
                        } else if let responseData = json["data"] as? [String: Any] {
                            if let accessToken = responseData["access_token"] as? String,
                               let refreshToken = responseData["refresh_token"] as? String,
                               let expiresIn = responseData["expires_in"] as? Int,
                               let createdAt = responseData["created_at"] as? Int {

                                KeychainManager.shared.saveCredentials(accessToken: accessToken, refreshToken: refreshToken, expiresIn: expiresIn, createdAt: createdAt)
                                completion(.success(0))
                            }
                        }
                    }
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                if error.localizedDescription != "" {
                    completion(.failure(APIError.serverNotReachableError))
                } else {
                    completion(.failure(error))
                }
            }
        }
    }

    func fetchUser(with accessToken: String, completion: @escaping (Result<UserInfo, Error>) -> Void) {
        guard isInternetConnected() else {
            completion(.failure(APIError.noInternetConnectionError))
            return
        }

        if isValid {
            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(accessToken)"
            ]

            AF.request("\(baseUrl)/api/v1/users", method: .get, headers: headers).responseJSON { response in
                switch response.result {
                case .success(let data):
                    if let json = data as? [String: Any],
                       let dataArray = json["data"] as? [[String: Any]],
                       let firstUser = dataArray.first,
                       let attributes = firstUser["attributes"] as? [String: Any],
                       let email = attributes["email"] as? String,
                       let firstName = attributes["first-name"] as? String {

                        let user = UserInfo(email: email, firstName: firstName, id: nil)
                        completion(.success(user))
                    } else {
                        completion(.failure(APIError.dataParsingError))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        } else if KeychainManager.shared.getRefreshToken() != nil {
            refreshTokenAndRetryRequest { _ in }
        }
    }

    func fetchDevices(with accessToken: String, completion: @escaping (Result<[DeviceModel], Error>) -> Void) {
        guard isInternetConnected() else {
            completion(.failure(APIError.noInternetConnectionError))
            return
        }

        if isValid {
            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(accessToken)"
            ]

            AF.request("\(baseUrl)/api/v1/devices", method: .get, headers: headers).responseJSON { response in
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
                        completion(.success(devices))
                    }
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
    }

    func refreshTokenAndRetryRequest(completion: @escaping (Result<Data, Error>) -> Void) {
        guard isInternetConnected() else {
            completion(.failure(APIError.noInternetConnectionError))
            return
        }

        let urlString = "\(baseUrl)/oauth/token"
        let refreshToken = KeychainManager.shared.getRefreshToken()

        let parameters: [String: Any] = [
            "client_id": oAuthClientId,
            "client_secret": oAuthClientSecret,
            "grant_type": "refresh_token",
            "refresh_token": refreshToken!
        ]

        AF.request(urlString, method: .post, parameters: parameters)
            .validate(statusCode: 200..<300) // Only consider success status codes
            .response { response in
                switch response.result {
                case .success(let data):
                    do {
                        if let jsonData = data, let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                            if let errors = json["errors"] as? [String], errors.count > 0 {
                                let errorMessage = errors[0]
                                completion(.failure(APIError.customError(errorMessage)))
                            } else {
                                if let accessToken = json["access_token"] as? String,
                                   let refreshToken = json["refresh_token"] as? String,
                                   let expiresIn = json["expires_in"] as? Int,
                                   let createdAt = json["created_at"] as? Int {

                                    KeychainManager.shared.saveCredentials(accessToken: accessToken, refreshToken: refreshToken, expiresIn: expiresIn, createdAt: createdAt)

                                    self.fetchUser(with: accessToken) { _ in }

                                    self.fetchDevices(with: accessToken) { _ in }

                                    completion(.success(data!))
                                }
                            }
                        }
                    } catch {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    if let httpResponse = response.response {
                        switch httpResponse.statusCode {
                        case 401, 403:
                            completion(.failure(APIError.authenticationError))
                        case 500:
                            completion(.failure(APIError.serverError))
                        default:
                            completion(.failure(error))
                        }
                    } else {
                        completion(.failure(error))
                    }
                }
            }
    }

    func createDevice(name: String, macAddr: String, completion: @escaping (Result<[DeviceModel], APIError>) -> Void) {
            guard isInternetConnected() else {
                completion(.failure(.noInternetConnectionError))
                return
            }

            if isValid {
                let endpoint = URL(string: "\(baseUrl)/api/v1/devices")!
                guard let accessToken = KeychainManager.shared.getAccessToken() else {
                    completion(.failure(.authenticationError))
                    return
                }

                let headers: HTTPHeaders = [
                    "Authorization": "Bearer \(accessToken)",
                    "Content-Type": "application/vnd.api+json"
                ]
                let parameters: [String: Any] = [
                    "data": [
                        "type": "devices",
                        "attributes": [
                            "name": name,
                            "mac-addr": macAddr
                        ]
                    ] as [String : Any]
                ]
                AF.request(endpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
                    .responseJSON { response in
                        switch response.result {
                        case .success(let data):
                            if let json = data as? [String: Any], let dataArray = json["data"] as? [[String: Any]] {
                                var devices: [DeviceModel] = []
                                for deviceData in dataArray {
                                    if let attributes = deviceData["attributes"] as? [String: Any], let name = attributes["name"] as? String {
                                        let device = DeviceModel(name: name)
                                        devices.append(device)
                                    }
                                }
                                completion(.success(devices))
                            } else {
                                completion(.failure(.dataParsingError))
                            }
                        case .failure(let error):
                            completion(.failure(.serverError))
                        }
                    }
            } else {
                completion(.failure(.customError("Invalid Request")))
            }
        }
}

enum APIError: Error {
    case noInternetConnectionError
    case serverNotReachableError
    case serverError
    case authenticationError
    case dataParsingError
    case customError(String)
}

extension APIError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noInternetConnectionError:
            return NSLocalizedString("Internet connection is not available", comment: "Not internet connection")
        case .serverNotReachableError:
            return NSLocalizedString("Unable to reach the server", comment: "Server not reachable")
        case .serverError:
            return NSLocalizedString("Error occured on the server", comment: "Server Error")
        case .authenticationError:
            return NSLocalizedString("Authentication Error", comment: "Authentication Error")
        case .dataParsingError:
            return NSLocalizedString("Error Parsing Data", comment: "Data Parsing Error")
        case .customError(let message):
            return NSLocalizedString(message, comment: message)
        }
    }
}
