//
//  KeyChainManager.swift
//  Aeroh Link
//
//  Created by Tanishq Patidar on 12/07/23.
//

import Foundation
import Security

class KeychainManager {
    static let shared = KeychainManager()
    
    private let accessTokenKey = "AccessToken"
    private let refreshTokenKey = "RefreshToken"
    private let expiresInKey = "ExpiresIn"
    private let createdAtKey = "CreatedAt"
    
    func saveCredentials(accessToken: String, refreshToken: String, expiresIn: Int, createdAt: Int) {
        saveValue(accessToken, forKey: accessTokenKey)
        saveValue(refreshToken, forKey: refreshTokenKey)
        saveValue(String(expiresIn), forKey: expiresInKey)
        saveValue(String(createdAt), forKey: createdAtKey)
    }
    
    func getAccessToken() -> String? {
        return getValue(forKey: accessTokenKey)
    }
    
    func getRefreshToken() -> String? {
        return getValue(forKey: refreshTokenKey)
    }
    
    func getExpiresIn() -> Int? {
        guard let expiresInString = getValue(forKey: expiresInKey) else {
            return nil
        }
        return Int(expiresInString)
    }
    
    func getCreatedAt() -> Int? {
        guard let createdAtString = getValue(forKey: createdAtKey) else {
            return nil
        }
        return Int(createdAtString)
    }
    
    private func saveValue(_ value: String, forKey key: String) {
        guard let data = value.data(using: .utf8) else {
            return
        }
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: data,
            kSecAttrAccessible as String: kSecAttrAccessibleWhenUnlocked 
        ]
        
        SecItemDelete(query as CFDictionary)
        
        let status = SecItemAdd(query as CFDictionary, nil)
        if status != errSecSuccess {
            print("Failed to save value to keychain: \(status)")
        }
    }
    
    private func getValue(forKey key: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnData as String: true
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        guard status == errSecSuccess,
              let data = result as? Data,
              let value = String(data: data, encoding: .utf8) else {
            return nil
        }
        
        return value
    }
}

