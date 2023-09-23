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
            Color("PrimaryBlack")
                .edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading, spacing: 15) {
                HStack {
                    Toggle("Vibrate on touch", isOn: $vibrateToggle)
                        .foregroundColor(.white)
                        .tint(Color("Action"))
                }
                Divider()
                    .frame(height: 1)
                    .overlay(Color("SecondaryBlack"))
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
                    .overlay(Color("SecondaryBlack"))
                NavigationLink(destination: ConfigureScreen(), label: {
                    Text("Configure")
                        .foregroundColor(.white)
                    Spacer()
                    Image("whiteArrowIcon")
                        .resizable()
                        .frame(width: 16, height: 16)
                })
                Divider()
                    .frame(height: 1)
                    .overlay(Color("SecondaryBlack"))
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
