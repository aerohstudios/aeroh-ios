//
//  WifiConnectionScreen.swift
//  Aeroh Link
//
//  Created by Tanishq Patidar on 18/08/23.
//

import SwiftUI

struct WifiConnectionScreen: View {
    @State private var wifiName = ""
    @State private var wifiPassword = ""
    var body: some View {
        
        ZStack{
            Color(red: 0.06, green: 0.05, blue: 0.08)
                .edgesIgnoringSafeArea(.all)
            
            
            VStack(spacing: 40){
                Spacer()
                VStack(spacing: 10) {
                    Text("Select a Wi-Fi Network and enter\npassword")
                        .lineSpacing(5)
                        .font(
                            Font.system(size: 18)
                                .weight(.semibold)
                        )
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                    
                    Text("You need to connect to wifi to instruct\naeroh link")
                        .font(Font.system(size: 16))
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(red: 0.75, green: 0.75, blue: 0.75))
                }
                
                
                
                Image("wifi-illustration")
                    .resizable()
                    .frame(width: 301, height: 172.68526)
                
                VStack(spacing: 25) {
                    TextField("Wi-Fi Name", text: $wifiName)
                        .foregroundColor(.white)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color(red: 0.16, green: 0.16, blue: 0.16), lineWidth: 1)
                            
                        )
                        .padding(.horizontal)
                        .colorScheme(.dark)
                    
                    SecureField("Password", text: $wifiPassword)
                        .foregroundColor(.white)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color(red: 0.16, green: 0.16, blue: 0.16), lineWidth: 1)
                        )
                        .padding(.horizontal)
                        .colorScheme(.dark)
                }
                Spacer()
                
                Button(action: {
                    
                    saveWiFiCredentials(ssid: wifiName, password: wifiPassword)
                }){
                    Text("Next")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(Color(red: 0.06, green: 0.05, blue: 0.08))
                        .background(Color(red: 1.00, green: 0.79, blue: 0.23))
                    
                        .clipShape(Capsule())
                        .padding(.horizontal)
                }
                
                
                
            }
        }.navigationTitle("Connect wifi")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                // Load saved WiFi credentials here
                loadWiFiCredentials()
            }
        
        
    }
    
    func saveWiFiCredentials(ssid: String, password: String) {
        let query: [CFString: Any] = [
            kSecClass: kSecClassInternetPassword,
            kSecAttrServer: ssid,
            kSecAttrAccount: "WiFi",
            kSecValueData: password.data(using: .utf8)!,
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        if status == errSecSuccess {
            print("WiFi credentials saved.")
        }
    }
    
    func loadWiFiCredentials() {
        let query: [CFString: Any] = [
            kSecClass: kSecClassInternetPassword,
            kSecAttrAccount: "WiFi",
            kSecReturnAttributes: true,
            kSecReturnData: true,
        ]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        if status == errSecSuccess {
            if let item = item as? [CFString: Any],
               let ssid = item[kSecAttrServer] as? String,
               let passwordData = item[kSecValueData] as? Data,
               let password = String(data: passwordData, encoding: .utf8) {
                wifiName = ssid
                wifiPassword = password
            }
        }
    }
}


struct WifiConnectionScreen_Previews: PreviewProvider {
    static var previews: some View {
        WifiConnectionScreen()
    }
}
