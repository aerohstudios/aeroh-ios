//
//  SignupScreen.swift
//  AerohLink
//
//  Created by Tanishq Patidar on 26/06/23.
//

import SwiftUI

struct SignupScreen: View {
    @State private var firstName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var firstNameError = false
    @State private var emailError = false
    @State private var passwordError = false
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @ObservedObject var loginManager: LoginManager

    var body: some View {
        ZStack {
            // Background color
            Color("PrimaryBlack")
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 30) {
                // Logo
                Image("logo-white")
                    .frame(height: 30)

                // Sign up title
                Text("Sign up")
                    .foregroundColor(Color("SecondaryWhite"))
                    .font(.title2)
                    .bold()

                if showAlert {
                    withAnimation {
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
                } else {
                    HStack {
                    }.frame(height: 18)
                }

                VStack(spacing: 22) {
                    // Name input field
                    VStack {
                        TextField("Name", text: $firstName)
                            .disableAutocorrection(true)
                            .foregroundColor(.white)
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(firstNameError ? Color.red : Color("SecondaryBlack"), lineWidth: 1)
                            )
                            .padding(.horizontal)
                            .colorScheme(.dark)

                        // Error message for empty first name
                        if firstNameError {
                            HStack {
                                Text("Please enter your name")
                                    .foregroundColor(.red)
                                    .font(.caption)
                                    .padding(.horizontal)
                                Spacer()
                            }.padding(.horizontal)
                        }
                    }

                    // Email input field
                    VStack {
                        TextField("Email", text: $email)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .foregroundColor(.white)
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(emailError ? Color.red : Color("SecondaryBlack"), lineWidth: 1)
                            )
                            .padding(.horizontal)
                            .colorScheme(.dark)
                        // Error message for invalid email format
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

                    // Password secure field
                    VStack {
                        SecureField("Password", text: $password)
                            .foregroundColor(.white)
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(passwordError ? Color.red : Color("SecondaryBlack"), lineWidth: 1)
                            )
                            .padding(.horizontal)
                            .colorScheme(.dark)

                        // Error message for weak password
                        if passwordError {
                            HStack {
                                Text("Password must be strong")
                                    .foregroundColor(.red)
                                    .font(.caption)
                                    .padding(.horizontal)

                                Spacer()
                            }.padding(.horizontal)
                        }
                    }
                }

                VStack(spacing: 22) {
                    // Sign up button
                    Button(action: {
                        // Handle sign up action
                        let isValid = validateForm()

                        if isValid {
                            SignupController().authenticate(firstName: firstName, email: email, password: password) { result in
                                switch result {
                                case .success:
                                    withAnimation {
                                        loginManager.login()
                                    }
                                case .failure(let error):
                                    showAlert(message: error.localizedDescription, duration: 3.0 )
                                }
                            }
                        }
                    }) {
                        Text("Sign up")
                            .frame(maxWidth: .infinity)   .padding()
                            .foregroundColor(Color("PrimaryBlack"))
                            .background(Color("Action"))
                            .clipShape(Capsule())
                            .padding(.horizontal)
                    }

                    // Separator and "OR" text
                    HStack {
                        Rectangle()
                            .frame(width: 50, height: 1)
                            .foregroundColor(.gray)

                        Text("OR")
                            .foregroundColor(Color("SecondaryWhite"))

                        Rectangle()
                            .frame(width: 50, height: 1)
                            .foregroundColor(.gray)
                    }

                    // Log in button
                    NavigationLink(destination: LoginScreen(loginManager: loginManager).navigationBarHidden(true), label: {
                        Text("Log in")
                            .frame(maxWidth: .infinity)       .padding()
                            .foregroundColor(.white)
                            .background(Color("PrimaryBlack"))
                            .cornerRadius(30)
                            .overlay(RoundedRectangle(cornerRadius: 30).stroke(Color.white, lineWidth: 1))
                            .padding(.horizontal)
                    }).navigationBarHidden(true)

                }
            }
            .padding(EdgeInsets(top: 30, leading: 0, bottom: 0, trailing: 0))
        }
    }
    private func showAlert(message: String, duration: Double) {
        alertMessage = message
        withAnimation {
            showAlert = true
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            withAnimation {
                showAlert = false
            }
            alertMessage = ""
        }

    }

    private func validateForm() -> Bool {
        firstNameError = false
        emailError = false

        guard !firstName.isEmpty else {
            firstNameError = true
            return false
        }

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

        // Check for strong password (minimum 8 characters, combination of letters, numbers, and special characters)
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        let isPasswordValid = passwordPredicate.evaluate(with: password)

        if !isPasswordValid {
            passwordError = true
            return false
        } else {
            passwordError = false
        }

        return true
    }
}

struct SignupScreen_Previews: PreviewProvider {
    static var previews: some View {
        let loginManager = LoginManager()
        SignupScreen(loginManager: loginManager)
    }
}
