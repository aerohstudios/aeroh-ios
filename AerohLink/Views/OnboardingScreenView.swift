//
//  OnboardingScreenView.swift
//  AerohLink
//
//  Created by Tanishq Patidar on 23/06/23.
//

import SwiftUI

struct OnboardingScreenView: View {
    @StateObject var loginManager = LoginManager()
    var body: some View {
        NavigationStack {
            ZStack {
                        // Background color
                        Color("PrimaryBlack")
                            .edgesIgnoringSafeArea(.all)

                        VStack(spacing: 179) {
                            VStack(spacing: 43) {
                                Spacer()

                                // AerohLinkIllustration Image
                                Image("AerohLinkIllustration")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)          .frame(maxWidth: 400)
                                    .padding([.leading, .trailing], 80)

                                // "Aeroh Link" Text
                                Text("Aeroh Link")
                                    .font(.title)
                                    .bold()
                                    .foregroundColor(.white)

                                // "Make your home smarter with Aeroh Link" Text
                                Text("Make your home smarter with Aeroh Link")
                                    .font(.body)
                                    .bold()
                                    .multilineTextAlignment(.center)
                                    .frame(width: 270)
                                    .foregroundColor(Color("SecondaryWhite"))
                            }

                            HStack(spacing: 23) {
                                // Sign up Button
                                NavigationLink(destination: SignupScreen(loginManager: loginManager).navigationBarHidden(true), label: {

                                    Text("Sign up")
                                        .frame(maxWidth: .infinity, minHeight: 25)
                                        .foregroundColor(.white)
                                        .padding()
                                        .background(Color("PrimaryBlack"))
                                        .cornerRadius(30)
                                        .overlay(RoundedRectangle(cornerRadius: 30).stroke(Color.white, lineWidth: 1))

                                })

                                // Login Button
                                NavigationLink(destination: LoginScreen(loginManager: loginManager).navigationBarHidden(true), label: {
                                    Text("Log in")
                                        .frame(maxWidth: .infinity, minHeight: 25)
                                        .foregroundColor(Color("PrimaryBlack"))
                                        .padding()
                                        .background(Color("Action"))
                                        .clipShape(Capsule())
                                })

                            }
                            .padding(.horizontal, 40)
                        }
                    }

        }.overlay(SplashScreen()) // Overlay SplashScreen

    }
}

struct OnboardingScreenView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingScreenView()
    }
}
