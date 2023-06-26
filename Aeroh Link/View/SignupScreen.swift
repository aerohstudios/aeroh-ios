//
//  SignupScreen.swift
//  Aeroh Link
//
//  Created by Tanishq Patidar on 26/06/23.
//

import SwiftUI

struct SignupScreen: View {
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        ZStack {
            // Background color
            Color(red: 0.06, green: 0.05, blue: 0.08)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                // Logo
                Image("logo-white")
                    .frame(height: 30)
                
                // Sign up title
                Text("Sign up")
                    .foregroundColor(Color(red: 0.75, green: 0.75, blue: 0.75))
                    .font(.title2)
                    .bold()
                
                VStack(spacing: 22) {
                    // Name input field
                    TextField("Name", text: $name)
                        .foregroundColor(.white)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color(red: 0.16, green: 0.16, blue: 0.16), lineWidth: 1)
                        )
                        .padding(.horizontal)
                        .colorScheme(.dark)
                    
                    // Email input field
                    TextField("Email", text: $email)
                        .foregroundColor(.white)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color(red: 0.16, green: 0.16, blue: 0.16), lineWidth: 1)
                        )
                        .padding(.horizontal)
                        .colorScheme(.dark)
                    
                    // Password secure field
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
                    // Sign up button
                    Button(action: {
                        // Handle sign up action
                    }) {
                        Text("Sign up")
                            .frame(width: 295)
                            .padding(.horizontal)
                            .foregroundColor(Color(red: 0.06, green: 0.05, blue: 0.08))
                            .padding()
                            .background(Color(red: 1.00, green: 0.79, blue: 0.23))
                            .clipShape(Capsule())
                    }
                    
                    // Separator and "OR" text
                    HStack {
                        Rectangle()
                            .frame(width: 50, height: 1)
                            .foregroundColor(.gray)
                        
                        Text("OR")
                            .foregroundColor(Color(red: 0.75, green: 0.75, blue: 0.75))
                        
                        Rectangle()
                            .frame(width: 50, height: 1)
                            .foregroundColor(.gray)
                    }
                    
                    // Log in button
                   NavigationLink(destination: LoginScreen().navigationBarHidden(true), label: {
                       Text("Log in")
                           .frame(width: 295)
                           .padding(.horizontal)
                           .foregroundColor(.white)
                           .padding()
                           .background(Color(red: 0.06, green: 0.05, blue: 0.08))
                           .cornerRadius(30)
                           .overlay(RoundedRectangle(cornerRadius: 30).stroke(Color.white, lineWidth: 1))
                   }).navigationBarHidden(true)
                        
                    
                }
            }
            .padding(EdgeInsets(top: 30, leading: 0, bottom: 0, trailing: 0))
        }
    }
}

struct SignupScreen_Previews: PreviewProvider {
    static var previews: some View {
        SignupScreen()
    }
}
