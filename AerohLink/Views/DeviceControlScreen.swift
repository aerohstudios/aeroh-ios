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
                    .foregroundColor(Color("PrimaryBlack"))
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color("Action"))
            .cornerRadius(5)
            .padding(.horizontal)
        }
    }

}
struct DeviceControlScreen: View {
    @StateObject var loginManager = LoginManager()
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                Color("PrimaryBlack")
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
            ToolbarItem(placement: .navigationBarLeading) {
                NavigationLink(destination: HomeScreen(loginManager: loginManager), label: {
                    Image("whiteArrowIcon")
                        .resizable()
                        .frame(width: 16, height: 16)
                        .rotationEffect(.degrees(-180))
                })
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: DeviceSettingsScreen(), label: {
                    Image(systemName: "gearshape.fill")
                        .font(.system(size: 16))
                        .foregroundColor(.white)
                })
            }
        }
        .navigationTitle("Aeroh Link")
        .navigationBarBackButtonHidden(true)
    }
}

struct DeviceControlScreen_Previews: PreviewProvider {
    static var previews: some View {
        DeviceControlScreen()
    }
}
