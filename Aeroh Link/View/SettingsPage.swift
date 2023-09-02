//
//  SettingsPage.swift
//  Aeroh Link
//
//  Created by Tanishq Patidar on 31/08/23.
//

import SwiftUI

struct SettingsPage: View {
    @AppStorage("demoMode") private var demoMode = false
    var body: some View {
        ZStack(alignment: .top) {
            Color(red: 0.06, green: 0.05, blue: 0.08)
                .edgesIgnoringSafeArea(.all)
            HStack{
                Toggle("Demo Mode", isOn: $demoMode)
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
