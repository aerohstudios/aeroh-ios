//
//  SettingsPage.swift
//  AerohLink
//
//  Created by Tanishq Patidar on 31/08/23.
//

import SwiftUI

struct SettingsPage: View {
    @AppStorage("demoMode") private var demoMode = false
    @AppStorage("showFirmwareUpdate") private var showFirmwareUpdate = false
    var body: some View {
        ZStack(alignment: .top) {
            Color("PrimaryBlack")
                .edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    Toggle("Demo Mode", isOn: $demoMode)
                }.padding()
                HStack {
                    Toggle("Show firmware Update", isOn: $showFirmwareUpdate)
                }.padding()
            }
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
