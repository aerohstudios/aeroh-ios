//
//  DeviceSettingsScreen.swift
//  AerohLink
//
//  Created by Tanishq Patidar on 12/09/23.
//

import SwiftUI

struct DeviceSettingsScreen: View {
    @State private var vibrateToggle = false
    var body: some View {
        ZStack(alignment: .top) {
            Color(red: 0.06, green: 0.05, blue: 0.08)
                .edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading, spacing: 15) {
                HStack {
                    Toggle("Vibrate on touch", isOn: $vibrateToggle)
                        .foregroundColor(.white)
                        .tint(Color(red: 1, green: 0.78, blue: 0.23))
                }
                Divider()
                    .frame(height: 1)
                    .overlay(Color(red: 0.16, green: 0.16, blue: 0.16))
                NavigationLink(destination: DeviceInfoScreen(), label: {
                    Text("Device Info")
                        .foregroundColor(.white)
                    Spacer()
                    Image("whiteArrowIcon")
                        .resizable()
                        .frame(width: 16, height: 16)
                })
                Divider()
                    .frame(height: 1)
                    .overlay(Color(red: 0.16, green: 0.16, blue: 0.16))
                NavigationLink(destination: DeviceNamingScreen(), label: {
                    Text("Configure")
                        .foregroundColor(.white)
                    Spacer()
                    Image("whiteArrowIcon")
                        .resizable()
                        .frame(width: 16, height: 16)
                })
                Divider()
                    .frame(height: 1)
                    .overlay(Color(red: 0.16, green: 0.16, blue: 0.16))
                Text("Delete")
                    .foregroundColor(.white)
            }
            .padding()
            .navigationTitle("Settings")
        }
    }
}

struct DeviceSettingsScreen_Previews: PreviewProvider {
    static var previews: some View {
        DeviceSettingsScreen()
    }
}
