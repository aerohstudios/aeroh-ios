//
//  DeviceRenameScreen.swift
//  AerohLink
//
//  Created by Tanishq Patidar on 13/09/23.
//

import SwiftUI

struct DeviceRenameScreen: View {
    @State private var deviceName = "Aeroh Link"
    var body: some View {
        ZStack(alignment: .top) {
            Color(red: 0.06, green: 0.05, blue: 0.08)
                .edgesIgnoringSafeArea(.all)

            VStack {
                TextField("Device Name", text: $deviceName)
                    .disableAutocorrection(true)
                    .foregroundColor(.white)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(Color(red: 0.16, green: 0.16, blue: 0.16), lineWidth: 1)
                    )
                    .padding()
                    .colorScheme(.dark)

                Spacer()

                NavigationLink(destination: DeviceInfoScreen(), label: {
                    Text("Save")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(Color(red: 0.06, green: 0.05, blue: 0.08))
                        .background(Color(red: 1.00, green: 0.79, blue: 0.23))
                        .clipShape(Capsule())
                        .padding(.horizontal)
                })
            }
        }.navigationTitle("Device name")
    }
}

struct DeviceRenameScreen_Previews: PreviewProvider {
    static var previews: some View {
        DeviceRenameScreen()
    }
}
