//
//  HomeScreen.swift
//  AerohLink
//
//  Created by Tanishq Patidar on 13/07/23.
//

import SwiftUI

struct HomeScreen: View {
        @State private var accessToken: String = ""
        @State private var refreshToken: String = ""
        @State private var expiresIn: Int = 0
        @State private var createdAt: Int = 0
        @ObservedObject var loginManager: LoginManager
        @State var show = false
        @StateObject private var userController = UserController()
        @StateObject private var devicesController = DevicesController()

        var body: some View {
        NavigationStack {
            ZStack(alignment: .trailing) {
                Color("PrimaryBlack").edgesIgnoringSafeArea(.all)

                GeometryReader { _ in
                    VStack(alignment: .leading) {
                        HStack(alignment: .center) {

                            VStack(alignment: .leading, spacing: 7) {
                                Text("Hi, \(UserDefaults.standard.string(forKey: "first_name") ?? "There")")
                                    .font(.system(size: 27))
                                    .foregroundColor(.white)
                                    .fontWeight(.semibold)
                                Text("Good to see you again")
                                    .font(.system(size: 15))
                                    .foregroundColor(Color("SecondaryWhite"))

                            }
                            Spacer()
                            Button(action: {
                                withAnimation(.default) {
                                    self.show.toggle()
                                }

                            }, label: {
                                Image("menu")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 30)

                            })

                        }.padding(.horizontal)

                        NavigationLink(destination: SearchBluetoothDevices()) {
                            Text("Add a new device")
                                .foregroundColor(.white)
                                .font(.system(size: 23))
                                .fontWeight(.semibold)
                        }.buttonStyle(AddNewDeviceButtonStyle())
                            .padding()

                        Text("Devices")
                            .padding(.horizontal)
                            .foregroundColor(Color("NonPrimaryText"))
                            .font(.system(size: 17))
                            .fontWeight(.semibold)

                        if devicesController.devices.count == 0 {
                            HStack(alignment: .center) {
                                Spacer()
                                VStack(alignment: .center, spacing: 10) {
                                    Spacer()
                                    Image("empty-box")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 70, height: 70)

                                    Text("No devices found \n Please add a new device")
                                        .font(Font.system( size: 15))
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(Color("SecondaryWhite"))

                                    Spacer()
                                }
                                Spacer()
                            }
                        } else {
                            ScrollView {
                                VStack(alignment: .leading, spacing: 20) {
                                    ForEach(Array(devicesController.devices.enumerated()), id: \.element.id) { index, device in
                                        DeviceRowView(device: device, isLastDevice: index == devicesController.devices.count - 1)
                                            .padding(.horizontal)
                                    }
                                }.padding(.vertical)
                            }
                        }
                    }

                }

                HStack {
                    Menu(loginManager: loginManager, show: self.$show)
                        .offset(x: self.show ? 0 : +UIScreen.main.bounds.width / 1.3)
                }
                .background(Color.primary.opacity(self.show ? 0.05 : 0).edgesIgnoringSafeArea(.all))
            }
            .navigationBarBackButtonHidden(true)
            .onAppear {
                loadKeychainValues()
                userController.fetchUser(accessToken: accessToken)
                if devicesController.devices.isEmpty {
                    devicesController.fetchDevicesIfNeeded(accessToken: accessToken)
                }
            }
        }
        .overlay(
            ErrorModalView(isShowing: $userController.showErrorAlert, errorLog: userController.error?.localizedDescription ?? "Error", supportEmail: "support@aeroh.org")
                )
    }

    private func loadKeychainValues() {
        accessToken = KeychainManager.shared.getAccessToken() ?? ""
        refreshToken = KeychainManager.shared.getRefreshToken() ?? ""
        expiresIn = KeychainManager.shared.getExpiresIn() ?? 0
        createdAt = KeychainManager.shared.getCreatedAt() ?? 0
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
                    .foregroundColor(.black)
                    .fontWeight(.semibold)
                    .frame(width: 44, height: 44)
                    .padding()
                    .background(
                        Circle()
                            .fill(Color("Action"))
                            .frame(width: 44, height: 44))

            }
            .padding(.horizontal, 30)
            .cornerRadius(20)
            .frame(maxWidth: .infinity, minHeight: 55)
            .background(Color("SecondaryBlack"))
            .clipShape(RoundedRectangle(cornerRadius: 20))
        }
    }

struct Menu: View {
    @ObservedObject var loginManager: LoginManager
    @State private var showingLogoutAlert = false
    @Binding var show: Bool

    var body: some View {
        VStack(alignment: .leading) {

            HStack {

                VStack(alignment: .leading, spacing: 5) {
                    Text(UserDefaults.standard.string(forKey: "first_name") ?? "First Name")
                        .font(.system(size: 27))
                        .foregroundColor(.white)
                        .fontWeight(.semibold)

                    Text(verbatim: UserDefaults.standard.string(forKey: "email") ?? "email")
                        .foregroundColor(Color("SecondaryWhite"))
                        .font(.system(size: 16))
                }
                .padding(.horizontal)
                Spacer()

                Button(action: {
                    withAnimation(.default) {
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

            NavigationLink(destination: SettingsPage(), label: {
                HStack {
                    Image(systemName: "slider.horizontal.3")
                        .foregroundColor(.white)
                    Text("Settings")
                        .foregroundColor(.white)
                }.padding()
            })

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
            .background((Color("PrimaryBlack")).edgesIgnoringSafeArea(.all))
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

struct DeviceRowView: View {
    var device: DeviceModel
    var isLastDevice: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            NavigationLink(destination: DeviceControlScreen(), label: {
                HStack(alignment: .center, spacing: 20) {
                    Image("AerohLinkIllustration")
                        .resizable()
                        .frame(width: 32.0, height: 19.34)
                        .aspectRatio(1, contentMode: .fit)
                        .padding()
                        .background(
                            Circle()
                                .fill(Color("SecondaryBlack"))
                                .frame(width: 60, height: 60))

                    VStack(alignment: .leading, spacing: 5) {
                        Text(device.name)
                            .font(.system(size: 18))
                            .foregroundColor(.white)
                    }
                    Spacer()
                }
            })

            if !isLastDevice {
                Divider()
                    .frame(height: 1)
                    .overlay(Color("SecondaryBlack"))
            }
        }
    }
}
