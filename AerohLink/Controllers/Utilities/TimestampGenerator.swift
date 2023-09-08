//
//  TimestampGenerator.swift
//  AerohLink
//
//  Created by Tanishq Patidar on 06/07/23.
//

import Foundation

class TimestampGenerator {
    static func generateTimestamp() -> Int {
        let timestamp = Int(Date().timeIntervalSince1970)
        return timestamp
    }
}
