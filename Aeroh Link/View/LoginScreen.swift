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
    @State private var isValid = false
    @State private var emailError = false
    @State private var passwordError = false
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @ObservedObject var loginManager : LoginManager
    
    var body: some View {
        
        ZStack {
            // Background color
            Color(red: 0.06, green: 0.05, blue: 0.08)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                // Logo Image
                Image("logo-white")
                    .frame(height: 30)
                
                VStack(spacing: 22){
                    // Login Text
                    Text("Log in")
                        .foregroundColor(Color(red: 0.75, green: 0.75, blue: 0.75))
                        .font(.title2)
                        .bold()
                    
                    if showAlert {
                        withAnimation{
                            HStack {
                                Image(systemName: "exclamationmark.triangle.fill")
                                    .font(.system(size: 14))
                                    .foregroundColor(.red)
                                Text(alertMessage)
                                    .foregroundColor(.red)
                                    .font(.subheadline)
                            }
                            .transition(.opacity)
                        }
                    }
                    else{
                        HStack{
                        }.frame(height: 18)
                    }
                }
                
                VStack(spacing: 22) {
                    // Email TextField
                    VStack {
                        TextField("Email", text: $email)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .foregroundColor(.white)
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(emailError ? Color.red : Color(red: 0.16, green: 0.16, blue: 0.16), lineWidth: 1)
                            )
                            .padding(.horizontal)
                            .colorScheme(.dark)
                        
                        if emailError {
                            HStack {
                                Text("Please enter a valid email")
                                    .foregroundColor(.red)
                                    .font(.caption)
                                    .padding(.horizontal)
                                
                                Spacer()
                            }.padding(.horizontal)
                        }
                    }
                    
                    
                    // Password SecureField
                    SecureField("Password", text: $password)
                        .foregroundColor(.white)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(passwordError ? Color.red : Color(red: 0.16, green: 0.16, blue: 0.16), lineWidth: 1)
                        )
                        .padding(.horizontal)
                        .colorScheme(.dark)
                }
                
                VStack(spacing: 22) {
                    // Log in Button
                    Button(action: {
                        isValid = validateForm()
                        
                        if isValid {
                            LoginController().authenticate(email: email, password: password, loginManager: loginManager, errorCallback: { errorMessage in
                                showAlert(message: errorMessage, duration: 3.0 )
                            }, successCallback: {
                                withAnimation{
                                    loginManager.login()
                                }
                            })
                        }
                        
                        
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
                    NavigationLink(destination: SignupScreen(loginManager: loginManager).navigationBarHidden(true), label: {
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
                    
                    Link("Forgot Password?", destination: URL(string: forgotPassword_url)!)
                        .foregroundColor(.accentColor)
                        .font(.caption)
                        .bold()
                    
                }
            }
        }
    }
    
    
    
    private func showAlert(message: String, duration: Double) {
        alertMessage = message
        withAnimation{
            showAlert = true
        }
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration){
            withAnimation{
                showAlert = false
            }
            
            alertMessage = ""
        }
    }
    
    private func validateForm() -> Bool {
        emailError = false
        
        guard !email.isEmpty else {
            emailError = true
            return false
        }
        
        // Check for correct email format using regular expression
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        let isEmailValid = emailPredicate.evaluate(with: email)
        
        if !isEmailValid {
            emailError = true
            return false
        }
        
        guard !password.isEmpty else {
            passwordError = true
            return false
        }
        
        return true
    }
    
}



struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        // Create an instance of LoginManager
        let loginManager = LoginManager()        // Pass the loginManager instance to the LoginScreen preview
        LoginScreen(loginManager: loginManager)
    }
    
}
