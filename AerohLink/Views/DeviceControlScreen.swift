//
//  DeviceControlScreen.swift
//  AerohLink
//
//  Created by Tanishq Patidar on 11/09/23.
//

import SwiftUI

struct CustomButton: View {
    let imageName: String
    let buttonText: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 10) {
                Image(imageName)
                    .resizable()
                    .frame(width: 24, height: 24)
                Text(buttonText)
                    .fontWeight(.medium)
                    .foregroundColor(Color(red: 0.06, green: 0.05, blue: 0.08))
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color(red: 1.00, green: 0.79, blue: 0.23))
            .cornerRadius(5)
            .padding(.horizontal)
        }
    }

}
struct DeviceControlScreen: View {
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                Color(red: 0.06, green: 0.05, blue: 0.08)
                    .edgesIgnoringSafeArea(.all)

                VStack(alignment: .center, spacing: 15) {
                    CustomButton(imageName: "powerIcon", buttonText: "Power") {
                    }
                    CustomButton(imageName: "speedIcon", buttonText: "Speed") {
                    }
                    CustomButton(imageName: "plusIcon", buttonText: "Temp up") {
                    }
                    CustomButton(imageName: "minusIcon", buttonText: "Temp down") {
                    }
                }
                .padding(.vertical)
            }
            .navigationBarBackButtonHidden(true)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: DeviceSettingsScreen(), label: {
                    Image(systemName: "gearshape.fill")
                        .foregroundColor(.white)
                })
            }
        }
        .navigationTitle("Aeroh Link")
    }
}

struct DeviceControlScreen_Previews: PreviewProvider {
    static var previews: some View {
        DeviceControlScreen()
    }
}
