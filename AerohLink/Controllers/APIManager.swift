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
    private let reachabilityManager = NetworkReachabilityManager()
    init() {}
    var isInternetConnected: Bool {
        return reachabilityManager?.isReachable ?? false
    }
    var isAccessTokenValid: Bool {
        return KeychainManager.shared.isAccessTokenValid()
    }
    var isValid: Bool {
        return isAccessTokenValid
    }
    func callingLoginAPI(userRequestData: UserModel, completion: @escaping (Result<Any, APIError>) -> Void) {
        guard isInternetConnected else {
            completion(.failure(.noInternetConnectionError))
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
                    completion(.failure(APIError.serverError))
                }
            }
        }
    }
    func callingSignupAPI(userRequestData: UserModel, completion: @escaping (Result<Any, APIError>) -> Void) {
        guard isInternetConnected else {
            completion(.failure(.noInternetConnectionError))
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
                    completion(.failure(APIError.serverError))
                }
            }
        }
    }
    func fetchUser(with accessToken: String, completion: @escaping (Result<UserInfo, Error>) -> Void) {
        guard isInternetConnected else {
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
                            case .failure:
                                completion(.failure(APIError.serverNotReachableError))
                            }
                        }
                    } else if KeychainManager.shared.getRefreshToken() != nil {
                        refreshTokenAndRetryRequest { result in
                                switch result {
                                case .success:
                                    break
                                case .failure:
                                    completion(.failure(APIError.serverNotReachableError))
                                }
                            }
                    }
    }
        func fetchDevices(with accessToken: String, completion: @escaping (Result<[DeviceModel], Error>) -> Void) {
            guard isInternetConnected else {
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
    func refreshTokenAndRetryRequest(completion: @escaping (Result<Data, APIError>) -> Void) {
        guard isInternetConnected else {
            completion(.failure(.noInternetConnectionError))
            return
        }
        guard let refreshToken = KeychainManager.shared.getRefreshToken() else {
            completion(.failure(.authenticationError))
            return
        }
        let urlString = "\(baseUrl)/oauth/token"
        let parameters: [String: Any] = [
            "client_id": oAuthClientId,
            "client_secret": oAuthClientSecret,
            "grant_type": "refresh_token",
            "refresh_token": refreshToken
        ]
        AF.request(urlString, method: .post, parameters: parameters)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: TokenResponse.self) { response in
                switch response.result {
                case .success(let tokenResponse):
                    KeychainManager.shared.saveCredentials(
                        accessToken: tokenResponse.accessToken,
                        refreshToken: tokenResponse.refreshToken,
                        expiresIn: tokenResponse.expiresIn,
                        createdAt: tokenResponse.createdAt
                    )
                    self.retryRefreshedTokenRequest(completion: completion)
                case .failure(let error):
                    self.handleTokenRefreshFailure(error: error, completion: completion)
                }
            }
    }
    func retryRefreshedTokenRequest(completion: @escaping (Result<Data, APIError>) -> Void) {
        guard let accessToken = KeychainManager.shared.getAccessToken() else {
            completion(.failure(.authenticationError))
            return
        }
        self.fetchUser(with: accessToken) { _ in }
        self.fetchDevices(with: accessToken) { _ in }
        completion(.success(Data()))
    }

    func handleTokenRefreshFailure(error: AFError, completion: @escaping (Result<Data, APIError>) -> Void) {
        if let httpResponse = error.responseCode {
            switch httpResponse {
            case 401, 403:
                completion(.failure(.authenticationError))
            case 500:
                completion(.failure(.serverError))
            default:
                completion(.failure(.customError(error.localizedDescription)))
            }
        } else {
            completion(.failure(APIError.serverNotReachableError))
        }
    }

    func createDevice(name: String, macAddr: String, completion: @escaping (Result<[DeviceModel], APIError>) -> Void) {
        guard isInternetConnected else {
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
            let deviceAttributes: [String: Any] = [
                "name": name,
                "mac-addr": macAddr
            ]
            let parameters: [String: Any] = [
                "data": [
                    "type": "devices",
                    "attributes": deviceAttributes
                ] as [String: Any]
            ]
            AF.request(endpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
                .responseDecodable(of: [DeviceModel].self) { response in
                    switch response.result {
                    case .success(let devices):
                        completion(.success(devices))
                    case .failure:
                        completion(.failure(.serverError))
                    }
                }
        } else if KeychainManager.shared.getRefreshToken() != nil {
            refreshTokenAndRetryRequest { _ in }
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
extension KeychainManager {
    internal func isAccessTokenValid() -> Bool {
        let tokenGenerationDate = KeychainManager.shared.getCreatedAt()
        let expiresIn = KeychainManager.shared.getExpiresIn()
        let currentDate = Date()
        let createdDateNewType = Date(timeIntervalSince1970: TimeInterval(tokenGenerationDate ?? 0))
        let expirationDate = createdDateNewType.addingTimeInterval(TimeInterval(expiresIn ?? 0))
        return expirationDate > currentDate
    }
}
