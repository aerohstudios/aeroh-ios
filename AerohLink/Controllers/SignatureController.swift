//
//  SignatureController.swift
//  AerohLink
//
//  Created by Tanishq Patidar on 06/07/23.
//

import Foundation
import CommonCrypto

class SignatureController {
    func login_signature(signData: UserModel, key: String) -> String {
        let payloadString = "\(signData.email)|\(signData.password)|\(signData.scopes)|\(signData.timestamp)"
        let payloadData = payloadString.data(using: .utf8)!
        let secretKeyData = key.data(using: .utf8)!
        let Signature = calculateHMAC(payload: payloadData, key: secretKeyData)
        return Signature
    }
    func signup_signature(signData: UserModel, key: String) -> String {
        let payloadString = "\(signData.email)|\(signData.password)|\(signData.first_name!)|\(signData.scopes)|\(signData.timestamp)"
        let payloadData = payloadString.data(using: .utf8)!
        let secretKeyData = key.data(using: .utf8)!
        let Signature = calculateHMAC(payload: payloadData, key: secretKeyData)
        return Signature
    }

    func calculateHMAC(payload: Data, key: Data) -> String {
        var signature = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))

        payload.withUnsafeBytes { dataBytes in
            key.withUnsafeBytes { keyBytes in
                CCHmac(CCHmacAlgorithm(kCCHmacAlgSHA256), keyBytes.baseAddress!, key.count, dataBytes.baseAddress!, payload.count, &signature)
            }
        }

        let hmacData = Data(bytes: signature, count: Int(CC_SHA256_DIGEST_LENGTH))
        return hmacData.map { String(format: "%02hhx", $0) }.joined()
    }
}
