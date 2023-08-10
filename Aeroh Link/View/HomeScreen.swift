//
//  HomeScreen.swift
//  Aeroh Link
//
//  Created by Tanishq Patidar on 13/07/23.
//

import SwiftUI

struct HomeScreen: View {
        @State private var accessToken: String = ""
        @State private var refreshToken: String = ""
        @State private var expiresIn: Int = 0
        @State private var createdAt: Int = 0
        @ObservedObject var loginManager : LoginManager
        @State var show = false
        @StateObject private var userController = UserController()
        
        var body: some View {
            ZStack(alignment: .trailing) {
                Color(red: 0.06, green: 0.05, blue: 0.08)
                    .edgesIgnoringSafeArea(.all)
                
                GeometryReader { _ in
                    VStack(alignment: .leading) {
                        HStack(alignment: .center){
                            
                            VStack(alignment: .leading, spacing: 7) {
                                Text("Hi, \(UserDefaults.standard.string(forKey: "first_name") ?? "There")")
                                    .font(.system(size: 27))
                                    .foregroundColor(.white)
                                    .fontWeight(.semibold)
                                Text("Good to see you again")
                                    .font(.system(size: 15))
                                    .foregroundColor(Color(red: 0.75, green: 0.75, blue: 0.75))
                                
                                
                            }
                            Spacer()
                            Button(action: {
                                withAnimation(.default){
                                    self.show.toggle()
                                }
                                
                            }, label: {
                                Image("menu")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 30)
                                
                            })
                            
                            
                        }.padding(.horizontal)
                        
                        Button {
                            
                        } label: {
                            Text("Add a new device")
                                .foregroundColor(.white)
                                .font(.system(size: 23))
                                .fontWeight(.semibold)
                        }.buttonStyle(AddNewDeviceButtonStyle())
                            .padding()
                        
                        Text("Devices")
                            .padding(.horizontal)
                            .foregroundColor(Color(red: 0.4, green: 0.4, blue: 0.4))
                            .font(.system(size: 17))
                            .fontWeight(.semibold)
                        
                    }
                    
                }
                
                
                HStack(){
                    Menu(loginManager: loginManager, show: self.$show)
                        .offset(x: self.show ? 0 : +UIScreen.main.bounds.width / 1.3)
                }
                .background(Color.primary.opacity(self.show ? 0.05 : 0).edgesIgnoringSafeArea(.all))
            }
            .onAppear {
                loadKeychainValues()
                UserController().fetchUsers(accessToken: accessToken) { users in
                    for user in users {
                        successCallback(user: user)
                    }
                }
            }
        }
        
        private func loadKeychainValues() {
            accessToken = KeychainManager.shared.getAccessToken() ?? ""
            refreshToken = KeychainManager.shared.getRefreshToken() ?? ""
            expiresIn = KeychainManager.shared.getExpiresIn() ?? 0
            createdAt = KeychainManager.shared.getCreatedAt() ?? 0
        }
        
        private func successCallback(user: UserInfo) {
            UserDefaults.standard.set(user.first_name, forKey: "first_name")
            UserDefaults.standard.set(user.email, forKey: "email")
        }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        let loginManager = LoginManager()
        HomeScreen(loginManager: loginManager)
    }
}

    struct AddNewDeviceButtonStyle: ButtonStyle {
        func makeBody(configuration: Configuration) -> some View {
            HStack {
                configuration.label
                Spacer()
                
                Image(systemName: "plus")
                    .font(.system(size: 20))
                    .fontWeight(.semibold)
                    .frame(width: 44, height: 44)
                    .padding()
                    .background(
                        Circle()
                            .fill(Color(red: 1, green: 0.78, blue: 0.23))
                            .frame(width: 44, height: 44))
                
                
            }
            .padding(.horizontal, 30)
            .cornerRadius(20)
            .frame(maxWidth: .infinity, minHeight: 55)
            .background(Color(red: 0.16, green: 0.16, blue: 0.16))
            .clipShape(RoundedRectangle(cornerRadius: 20))
        }
    }

struct Menu: View {
    @ObservedObject var loginManager : LoginManager
    @State private var showingLogoutAlert = false
    @Binding var show: Bool
    
    
    var body: some View {
        VStack(alignment: .leading){
            
            HStack{
                
                VStack(alignment: .leading , spacing: 5) {
                    Text(UserDefaults.standard.string(forKey: "first_name") ?? "First Name")
                        .font(.system(size: 27))
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                    
                    Text(verbatim: UserDefaults.standard.string(forKey: "email") ?? "email")
                        .foregroundColor(Color(red: 0.75, green: 0.75, blue: 0.75))
                        .font(.system(size: 16))
                }
                .padding(.horizontal)
                Spacer()
                
                Button (action: {
                    withAnimation(.default){
                        self.show.toggle()
                    }
                }) {
                    Image(systemName: "arrow.right")
                        .font(.system(size: 24))
                        .foregroundColor(.white)
                    
                    
                }
            }
            .padding(.top)
            .padding(.bottom, 25)
            
            Button(action: {
                showingLogoutAlert = true
            }, label: {
                HStack {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                        .foregroundColor(.white)
                    Text("Logout")
                        .foregroundColor(.white)
                }.padding()
            })
            
            Spacer()
        }.frame(width: UIScreen.main.bounds.width / 1.5)
            .padding(.horizontal, 20)
            .background((Color(red: 0.06, green: 0.05, blue: 0.08)).edgesIgnoringSafeArea(.all))
            .overlay(Rectangle().stroke(Color.primary.opacity(0.2), lineWidth: 2).shadow(radius: 3).edgesIgnoringSafeArea(.all))
            .alert(isPresented: $showingLogoutAlert) {
                Alert(title: Text("Logout"),
                      message: Text("Are you sure you want to logout?"),
                      primaryButton: .destructive(Text("Logout")) {
                    loginManager.logout()
                    deleteKeychainValues()
                },
                      secondaryButton: .cancel())
            }
    }
    private func deleteKeychainValues() {
        KeychainManager.shared.deleteValue(forKey: KeychainManager.shared.accessTokenKey)
        KeychainManager.shared.deleteValue(forKey: KeychainManager.shared.refreshTokenKey)
        KeychainManager.shared.deleteValue(forKey: KeychainManager.shared.expiresInKey)
        KeychainManager.shared.deleteValue(forKey: KeychainManager.shared.createdAtKey)
    }
}
