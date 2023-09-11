//
//  WifiConnectionScreen.swift
//  AerohLink
//
//  Created by Tanishq Patidar on 18/08/23.
//

import SwiftUI
import Security
import NetworkExtension
import Combine
import CoreFoundation
import SystemConfiguration.CaptiveNetwork
import CoreLocation

class WiFiListViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var wifiNetworks: [String] = []
    @State var demoWifiNetworks: [String] = ["Aeroh Home Wi-Fi", "Aeroh Corp Wi-Fi"]

    var locationManager: CLLocationManager

    override init() {
        locationManager = CLLocationManager()
        super.init()
        locationManager.delegate = self
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            fetchWiFiNetworks()
        case .denied, .restricted:
            print("Here2")
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        @unknown default:
            break
        }
    }

    func fetchWiFiNetworks() {
        if let interfaces = CNCopySupportedInterfaces() as? [String] {
            for interface in interfaces {
                if let info = CNCopyCurrentNetworkInfo(interface as CFString) as NSDictionary? {
                    if let ssid = info[kCNNetworkInfoKeySSID as String] as? String {
                        wifiNetworks.append(ssid)
                    }
                }
            }
        }
    }
}

struct WifiConnectionScreen: View {
    @State private var wifiName = ""
    @State private var wifiPassword = ""
    @State private var savedPassword = ""
    @ObservedObject var viewModel = WiFiListViewModel()
    @AppStorage("demoMode") private var demoMode = false
    @StateObject private var newDeviceController = NewDeviceController()

    var body: some View {
        NavigationView {
            if demoMode {
                Form {
                    if wifiName.isEmpty {
                        Section {
                            HStack(spacing: 10) {
                                ProgressView()
                                    .foregroundColor(.gray)
                                Text("Searching for nearby networks")
                            }
                        }
                    } else {
                        Section {
                            VStack(spacing: 10) {
                                Text("Select your Wi-Fi Network and enter password")
                                    .font(.headline)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.white)

                                Text("You need to connect Aeroh Link to Wi-Fi to use it")
                                    .font(.subheadline)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.gray)

                                Image("wifi-illustration")
                                    .resizable()
                                    .frame(width: 301, height: 172.68526)
                            }
                        }

                        Section {
                            Text(wifiName)
                                .foregroundColor(.white)

                            if !savedPassword.isEmpty {
                                DisclosureGroup("Saved Password") {
                                    Text(savedPassword)
                                        .onTapGesture {
                                            wifiPassword = savedPassword

                                        }
                                }
                            }
                            SecureField("Password", text: $wifiPassword)
                                .foregroundColor(.white)
                                .textFieldStyle(RoundedBorderTextFieldStyle())

                        }

                        Section {
                            NavigationLink(destination: DeviceNamingScreen(), label: {
                                Button(action: {
                                    saveWiFiCredentials(ssid: wifiName, password: wifiPassword)
                                }) {
                                    Text("Next")
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .foregroundColor(Color(red: 0.06, green: 0.05, blue: 0.08))
                                        .background(Color(red: 1.00, green: 0.79, blue: 0.23))
                                        .clipShape(Capsule())
                                        .padding(.horizontal)
                                }
                            })
                        }
                    }

                    Section {
                        List(viewModel.demoWifiNetworks, id: \.self) { network in
                            HStack {
                                Image(systemName: "wifi")
                                    .foregroundColor(.white)
                                Text(network)
                            }
                            .onTapGesture {
                                withAnimation {
                                    self.wifiName = network
                                    loadWiFiCredentials()
                                }
                            }
                        }
                    }
                }
            } else {
                Form {
                    if wifiName.isEmpty {
                        Section {
                            HStack(spacing: 10) {
                                ProgressView()
                                    .foregroundColor(.gray)
                                Text("Searching for nearby devices")
                            }
                        }
                    } else {
                        Section {
                            VStack(spacing: 10) {
                                Text("Select your Wi-Fi Network and enter password")
                                    .font(.headline)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.white)

                                Text("You need to connect Aeroh Link to Wi-Fi to use it")
                                    .font(.subheadline)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.gray)

                                Image("wifi-illustration")
                                    .resizable()
                                    .frame(width: 301, height: 172.68526)
                            }
                        }

                        Section {
                            Text(wifiName)
                                .foregroundColor(.white)

                            if !savedPassword.isEmpty {
                                DisclosureGroup("Saved Password") {
                                    Text(savedPassword)
                                        .onTapGesture {
                                            wifiPassword = savedPassword

                                        }
                                }
                            }
                            SecureField("Password", text: $wifiPassword)
                                .foregroundColor(.white)
                                .textFieldStyle(RoundedBorderTextFieldStyle())

                        }

                        Section {
                            NavigationLink(destination: DeviceNamingScreen(), label: {
                                Button(action: {
                                    saveWiFiCredentials(ssid: wifiName, password: wifiPassword)
                                    newDeviceController.createDevice(name: "Aeroh Link", macAddr: "12:AB:34:CD:56:EF") { _ in
                                    }
                                }) {
                                    Text("Next")
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .foregroundColor(Color(red: 0.06, green: 0.05, blue: 0.08))
                                        .background(Color(red: 1.00, green: 0.79, blue: 0.23))
                                        .clipShape(Capsule())
                                        .padding(.horizontal)
                                }
                            })
                        }
                    }

                    Section {
                        List(viewModel.wifiNetworks, id: \.self) { network in
                            HStack {
                                Image(systemName: "wifi")
                                    .foregroundColor(.white)
                                Text(network)
                            }
                            .onTapGesture {
                                withAnimation {
                                    self.wifiName = network
                                    loadWiFiCredentials()
                                }
                            }
                        }
                    }
                }
                .background(Color(red: 0.06, green: 0.05, blue: 0.08).edgesIgnoringSafeArea(.all))
            }
        }.navigationTitle("Connect Wi-Fi")
            .navigationBarTitleDisplayMode(.inline)

    }

    func saveWiFiCredentials(ssid: String, password: String) {
        UserDefaults.standard.set(ssid, forKey: "savedWifiName")
        UserDefaults.standard.set(password, forKey: "savedWifiPassword")
    }

    func loadWiFiCredentials() {
        let savedSsid = UserDefaults.standard.string(forKey: "savedWifiName")
        let savedWifiPassword = UserDefaults.standard.string(forKey: "savedWifiPassword")
        if savedSsid != nil && wifiName == savedSsid {
            savedPassword = savedWifiPassword!
        }
    }
}

struct WifiConnectionScreen_Previews: PreviewProvider {
    static var previews: some View {
        WifiConnectionScreen()
    }
}
