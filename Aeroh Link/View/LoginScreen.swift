//
//  LoginScreen.swift
//  Aeroh Link
//
//  Created by Tanishq Patidar on 26/06/23.
//

import SwiftUI

struct LoginScreen: View {
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        ZStack {
            // Background color
            Color(red: 0.06, green: 0.05, blue: 0.08)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                // Logo Image
                Image("logo-white")
                    .frame(height: 30)
                
                // Login Text
                Text("Log in")
                    .foregroundColor(Color(red: 0.75, green: 0.75, blue: 0.75))
                    .font(.title2)
                    .bold()
                
                VStack(spacing: 22) {
                    // Email TextField
                    TextField("Email", text: $email)
                        .foregroundColor(.white)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color(red: 0.16, green: 0.16, blue: 0.16), lineWidth: 1)
                        )
                        .padding(.horizontal)
                        .colorScheme(.dark)
                    
                    // Password SecureField
                    SecureField("Password", text: $password)
                        .foregroundColor(.white)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color(red: 0.16, green: 0.16, blue: 0.16), lineWidth: 1)
                        )
                        .padding(.horizontal)
                        .colorScheme(.dark)
                }
                
                VStack(spacing: 22) {
                    // Log in Button
                    Button(action: {
                        // Handle login action
                    }) {
                        Text("Log in")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(Color(red: 0.06, green: 0.05, blue: 0.08))
                            .background(Color(red: 1.00, green: 0.79, blue: 0.23))
                        
                            .clipShape(Capsule())
                            .padding(.horizontal)
                    }
                    
                    HStack(spacing: 7) {
                        // Line on the left
                        Rectangle()
                            .frame(width: 50, height: 1)
                            .foregroundColor(Color(red: 0.75, green: 0.75, blue: 0.75))
                        
                        // OR Text
                        Text("OR")
                            .foregroundColor(Color(red: 0.75, green: 0.75, blue: 0.75))
                        
                        // Line on the right
                        Rectangle()
                            .frame(width: 50, height: 1)
                            .foregroundColor(Color(red: 0.75, green: 0.75, blue: 0.75))
                    }
                    
                    // Sign up Button
                    NavigationLink(destination: SignupScreen().navigationBarHidden(true), label: {
                        Text("Sign up")
                            .frame(maxWidth: .infinity)                            .padding()
                            .foregroundColor(.white)
                            .background(Color(red: 0.06, green: 0.05, blue: 0.08))
                            .cornerRadius(30)
                            .overlay(
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(Color.white, lineWidth: 1)
                            )
                            .padding(.horizontal)
                    }).navigationBarHidden(true)
                        
                   
                    
                    // Forgot Password Button
                    Button(action: {
                        // Handle forgot password action
                    }) {
                        Text("Forgot Password?")
                            .foregroundColor(.accentColor)
                            .font(.caption)
                            .bold()
                    }
                }
            }
        }
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
    }
}
