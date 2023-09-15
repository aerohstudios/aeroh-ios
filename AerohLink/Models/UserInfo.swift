//
//  UserInfo.swift
//  AerohLink
//
//  Created by Tanishq Patidar on 07/08/23.
//
import Foundation

struct UserInfo: Codable {

    let email: String
    let firstName: String
    let id: Int?
}

struct TokenResponse: Decodable {
    let accessToken: String
    let refreshToken: String
    let expiresIn: Int
    let createdAt: Int

    private enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case expiresIn = "expires_in"
        case createdAt = "created_at"
    }
}
