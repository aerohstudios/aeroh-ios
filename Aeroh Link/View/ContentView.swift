//
//  ContentView.swift
//  Aeroh Link
//
//  Created by Tanishq Patidar on 15/06/23.
//

import SwiftUI

struct ContentView: View {
    @State private var showLoginScreen = false
    
    var body: some View {
        ZStack {
            // Background color
            Color(red: 0.06, green: 0.05, blue: 0.08)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 179) {
                VStack(spacing: 43) {
                    Spacer()
                    
                    // AerohLinkIllustration Image
                    Image("AerohLinkIllustration")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 120.9)
                    
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
                        .foregroundColor(Color(red: 0.75, green: 0.75, blue: 0.75))
                }
                
                HStack(spacing: 23) {
                    // Sign up Button
                    Button(action: {
                        // Handle sign up action
                    }) {
                        Text("Sign up")
                            .frame(width: 110, height: 25)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color(red: 0.06, green: 0.05, blue: 0.08))
                            .cornerRadius(30)
                            .overlay(RoundedRectangle(cornerRadius: 30).stroke(Color.white, lineWidth: 1))
                    }
                    
                    // Login Button
                    Button(action: {
                        showLoginScreen.toggle()
                    }) {
                        Text("Login")
                            .frame(width: 110, height: 25)
                            .foregroundColor(Color(red: 0.06, green: 0.05, blue: 0.08))
                            .padding()
                            .background(Color(red: 1.00, green: 0.79, blue: 0.23))
                            .clipShape(Capsule())
                    }
                }
                .padding(.horizontal, 40)
            }
        }
        .overlay(SplashScreen()) // Overlay SplashScreen
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
