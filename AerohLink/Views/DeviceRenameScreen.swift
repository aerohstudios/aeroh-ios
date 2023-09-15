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
            Color("PrimaryBlack")
                .edgesIgnoringSafeArea(.all)

            VStack {
                TextField("Device Name", text: $deviceName)
                    .disableAutocorrection(true)
                    .foregroundColor(.white)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(Color("SecondaryBlack"), lineWidth: 1)
                    )
                    .padding()
                    .colorScheme(.dark)

                Spacer()

                NavigationLink(destination: DeviceInfoScreen(), label: {
                    Text("Save")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(Color("PrimaryBlack"))
                        .background(Color("Action"))
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
