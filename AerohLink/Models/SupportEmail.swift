//
//  SupportEmail.swift
//  AerohLink
//
//  Created by Tanishq Patidar on 19/09/23.
//

import UIKit
import SwiftUI

struct SupportEmail {
    let toAddress: String
    let subject: String
    let messageHeader: String
    let errorLog: String
    var body: String {
        """
\(messageHeader):
-----------------------------------


-----------------------------------
Metadata
-----------------------------------
Application Name: \(Bundle.main.displayName)
iOS: \(UIDevice.current.systemVersion)
Device Model: \(UIDevice.current.modelName)
App Version: \(Bundle.main.appVersion)
App Build: \(Bundle.main.appBuild)
Error: \(errorLog)
Stack Trace:

\(Thread.callStackSymbols.joined(separator: "\n"))
"""
    }
    func send(openURL: OpenURLAction) {
        let urlString = "mailto:\(toAddress)?subject=\(subject.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? "")&body=\(body.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? "")"
        guard let url = URL(string: urlString) else { return  }
        openURL(url) { accepted in
            if !accepted {
                print(
                """
                This device does not support email \(body)
                """)
            }
        }
    }
}
