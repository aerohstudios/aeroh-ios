//
//  ErrorModalComponent.swift
//  AerohLink
//
//  Created by Tanishq Patidar on 19/09/23.
//

import SwiftUI

struct ErrorModalView: View {
    @Binding var isShowing: Bool
    var errorLog = "error"
    let supportEmail: String
    @Environment(\.openURL) var openURL
    var email: SupportEmail {
        SupportEmail(
            toAddress: "support@aeroh.org",
            subject: "Support Email",
            messageHeader: "Please describe your issue below",
            errorLog: errorLog
        )
    }
    init(isShowing: Binding<Bool>, errorLog: String, supportEmail: String) {
        self._isShowing = isShowing
        self.errorLog = errorLog
        self.supportEmail = supportEmail
    }
    var body: some View {
        ZStack {
            Color.black.opacity(0.3).edgesIgnoringSafeArea(.all)
            VStack(spacing: 20) {
                VStack(spacing: 12) {
                    Text("Error Occurred")
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                    Text(errorLog)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color("SecondaryWhite"))
                        .padding(.horizontal)
                }
                .padding(.top)
                VStack(spacing: 12) {
                    Button(action: {
                        email.send(openURL: openURL)
                        withAnimation {
                            isShowing = false
                        }
                    }) {
                        Text("Report")
                            .frame(maxWidth: .infinity)
                            .padding(8)
                            .foregroundColor(Color("PrimaryBlack"))
                            .background(Color("Action"))
                            .clipShape(Capsule())
                    }
                    Button(action: {
                        withAnimation {
                            isShowing = false
                        }
                    }) {
                        Text("Cancel")
                            .frame(maxWidth: .infinity)                            .padding(8)
                            .foregroundColor(.white)
                            .background(Color("SecondaryBlack"))
                            .cornerRadius(30)
                            .overlay(
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(Color.white, lineWidth: 1)
                            )                  }
                }
                .padding(.bottom)
            }
            .shadow(radius: 5)
            .padding()
            .background(Color("SecondaryBlack"))
            .cornerRadius(20)
            .shadow(radius: 5)
            .padding(.vertical, 100)
            .padding(.horizontal, 50)
        }
        .opacity(isShowing ? 1.0 : 0.0)
    }
}
