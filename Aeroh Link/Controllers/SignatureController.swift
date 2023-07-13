//
//  SignatureController.swift
//  Aeroh Link
//
//  Created by Tanishq Patidar on 06/07/23.
//

import Foundation
import CommonCrypto

class SignatureController {
    func hmacSha256_login(signData: signData_login, key: String) -> String {
        let data = "\(signData.email)|\(signData.password)|\(signData.scopes)|\(signData.timestamp)"
        let dataToHmac = data.data(using: .utf8)!
        let keyData = key.data(using: .utf8)!
        
        var digest = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
        dataToHmac.withUnsafeBytes { dataBytes in
            keyData.withUnsafeBytes { keyBytes in
                CCHmac(CCHmacAlgorithm(kCCHmacAlgSHA256), keyBytes.baseAddress!, keyData.count, dataBytes.baseAddress!, dataToHmac.count, &digest)
            }
        }
        
        let hmacData = Data(bytes: digest, count: Int(CC_SHA256_DIGEST_LENGTH))
        return hmacData.map { String(format: "%02hhx", $0) }.joined()
    }
    func hmacSha256_signup(signData: signData_signup, key: String) -> String {
        let data = "\(signData.email)|\(signData.password)|\(signData.first_name)|\(signData.scopes)|\(signData.timestamp)"
        let dataToHmac = data.data(using: .utf8)!
        let keyData = key.data(using: .utf8)!
        
        var digest = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
        dataToHmac.withUnsafeBytes { dataBytes in
            keyData.withUnsafeBytes { keyBytes in
                CCHmac(CCHmacAlgorithm(kCCHmacAlgSHA256), keyBytes.baseAddress!, keyData.count, dataBytes.baseAddress!, dataToHmac.count, &digest)
            }
        }
        
        let hmacData = Data(bytes: digest, count: Int(CC_SHA256_DIGEST_LENGTH))
        return hmacData.map { String(format: "%02hhx", $0) }.joined()
    }
}
