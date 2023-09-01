//
//  SettingsPage.swift
//  Aeroh Link
//
//  Created by Tanishq Patidar on 31/08/23.
//

import SwiftUI

struct SettingsPage: View {
    //    @State private var isToggleOn = false
    @AppStorage("isToggleOn") private var isToggleOn = false
    var body: some View {
        ZStack(alignment: .top) {
            Color(red: 0.06, green: 0.05, blue: 0.08)
                .edgesIgnoringSafeArea(.all)
            HStack{
                Toggle("Bluetooth dev mode", isOn: $isToggleOn)
                    .onChange(of: isToggleOn) { newValue in
                        if newValue {
                            print("Toggle is ON")
                        } else {
                            print("Toggle is OFF")
                        }
                    }
            }.padding()
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SettingsPage_Previews: PreviewProvider {
    static var previews: some View {
        SettingsPage()
    }
}
