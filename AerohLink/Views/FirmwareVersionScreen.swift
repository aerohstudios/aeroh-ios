//
//  FirmwareVersionScreen.swift
//  AerohLink
//
//  Created by Tanishq Patidar on 20/09/23.
//

import SwiftUI

struct FirmwareVersionScreen: View {
    @State private var isLoading = true
    @AppStorage("showFirmwareUpdate") private var updateAvailable = false
    var body: some View {
        ZStack(alignment: .center) {
            Color("PrimaryBlack").edgesIgnoringSafeArea(.all)
            if isLoading {
                VStack(spacing: 48) {
                    Image("firmwareIllustration")
                    HStack(spacing: 8) {
                        ProgressView()
                            .foregroundColor(Color("White"))
                        Text("Check for updates")
                    }
                }
            } else if updateAvailable {
                VStack(spacing: 40) {
                    Text("Your device has a new firmware update available")
                        .font(
                            Font.system(size: 20)
                                .weight(.bold)
                        )
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .frame(width: 293, alignment: .top)
                    VStack {
                        Image("AerohLinkIllustration")
                            .resizable()
                            .frame(width: 128, height: 80)
                            .aspectRatio(1, contentMode: .fit)
                            .padding()
                            .overlay(
                                Circle()
                                    .stroke(Color("SecondaryBlack"), lineWidth: 1)
                                    .frame(width: 245, height: 245)
                            )
                    }.frame(width: 245, height: 245)
                    VStack(spacing: 15) {
                        Text("Aeroh Link")
                            .font(
                                Font.system(size: 20)
                                    .weight(.semibold)
                            )
                            .foregroundColor(.white)
                        Text("v1.3.1")
                            .font(Font.system(size: 16))
                            .foregroundColor(Color("SecondaryWhite"))
                    }
                    Spacer()
                    VStack {
                        Text("Latest version: v1.3.2")
                          .font(Font.system(size: 16))
                          .foregroundColor(Color("SecondaryWhite"))
                        NavigationLink(destination: FirmwareUpdateScreen(), label: {
                            Text("Update")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .foregroundColor(Color("PrimaryBlack"))
                                .background(Color("Action"))
                                .clipShape(Capsule())
                                .padding(.horizontal)
                        })
                    }
                }
            } else {
                VStack(spacing: 48
                ) {
                    Text("Your device is running the latest firmware version")
                        .font(
                            Font.system(size: 20)
                                .weight(.bold)
                        )
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .frame(width: 293, alignment: .top)
                    VStack {
                        Image("AerohLinkIllustration")
                            .resizable()
                            .frame(width: 128, height: 80)
                            .aspectRatio(1, contentMode: .fit)
                            .padding()
                            .overlay(
                                Circle()
                                    .stroke(Color("SecondaryBlack"), lineWidth: 1)
                                    .frame(width: 245, height: 245)
                            )
                    }.frame(width: 245, height: 245)
                    VStack(spacing: 15) {
                        Text("Aeroh Link")
                            .font(
                                Font.system(size: 20)
                                    .weight(.semibold)
                            )
                            .foregroundColor(.white)
                        Text("v1.0.2.66")
                            .font(Font.system(size: 16))
                            .foregroundColor(Color("SecondaryWhite"))
                    }
                    Spacer()
                    NavigationLink(destination: DeviceInfoScreen(), label: {
                        Text("Okay")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(Color("PrimaryBlack"))
                            .background(Color("Action"))
                            .clipShape(Capsule())
                            .padding(.horizontal)
                    })
                }
            }
        }.onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                withAnimation {
                    isLoading = false
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct FirmwareVersionScreen_Previews: PreviewProvider {
    static var previews: some View {
        FirmwareVersionScreen()
    }
}
