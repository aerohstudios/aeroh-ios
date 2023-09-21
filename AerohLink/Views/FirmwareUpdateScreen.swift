//
//  FirmwareUpdateScreen.swift
//  AerohLink
//
//  Created by Tanishq Patidar on 20/09/23.
//

import SwiftUI

struct FirmwareUpdateScreen: View {
    @State private var progress: Double = 0.0
    @State private var installing: Bool = false
    @State private var showSuccess: Bool = false
    @State private var showError: Bool = false

    var body: some View {
        ZStack(alignment: .bottom) {
            Color("PrimaryBlack")
                .edgesIgnoringSafeArea(.all)
            if !showError {
                VStack(spacing: 60) {
                    ZStack {
                        Circle()
                            .stroke(Color("SecondaryBlack"), lineWidth: 1)
                            .frame(width: 245, height: 245)
                        if !installing {
                            Text("Requested")
                                .font(Font.system(size: 32))
                                .foregroundColor(Color("SecondaryWhite"))
                        } else if showSuccess {
                            Text("🎉")
                                .font(Font.system(size: 80))
                        } else {
                            HStack(spacing: 10) {
                                LoadingView(text: "Installing")
                        }
                        }
                    }
                    VStack(spacing: 15) {
                        if showSuccess {
                            Text("Your device was updated successfully ")
                                .font(
                                    Font.system(size: 20)
                                        .weight(.semibold)
                                )
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                                .frame(width: 281, alignment: .top)
                            Text("Updated version: v1.3.2")
                                .font(Font.system(size: 16))
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color("SecondaryWhite"))
                                .frame(width: 253, alignment: .top)
                        } else {
                            Text(installing ? "Installing the new version of software" : "Update has been requested")
                                .font(
                                    Font.system(size: 20)
                                        .weight(.semibold)
                                )
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                                .frame(width: 281, alignment: .top)
                            Text("Please do not close the app or turn off the internet or disconnect the device")
                                .font(Font.system(size: 16))
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color("SecondaryWhite"))
                                .frame(width: 253, alignment: .top)
                        }
                    }
                    if showSuccess {
                        NavigationLink(destination: DeviceInfoScreen(), label: {
                            Text("Okay")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .foregroundColor(Color("PrimaryBlack"))
                                .background(Color("Action"))
                                .clipShape(Capsule())
                                .padding(.horizontal)
                        }).padding(.top, 150)
                    } else {
                        Image(systemName: installing ? "arrow.2.circlepath.circle.fill" : "square.and.arrow.down.fill")
                            .foregroundColor(Color("Action"))
                            .font(.system(size: 60))
                            ProgressView(value: progress, total: 100)
                                                    .tint(Color("Action"))
                                                    .progressViewStyle(LinearProgressViewStyle())
                                                    .padding()
                    }
                }
            } else {
                VStack(spacing: 60) {
                    Spacer()
                    ZStack {
                        Circle()
                            .stroke(Color("SecondaryBlack"), lineWidth: 1)
                            .frame(width: 245, height: 245)
                        Image("warningError")
                            .resizable()
                            .frame(width: 100, height: 100)
                    }
                    Text("There was an error installing the update")
                        .font(
                            Font.system(size: 20)
                                .weight(.semibold)
                        )
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .frame(width: 281, alignment: .top)
                    Text("Please select the below option to continue")
                        .font(Font.system(size: 16))
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color("SecondaryWhite"))
                        .frame(width: 253, alignment: .top)
                    VStack(spacing: 16) {
                        NavigationLink(destination: FirmwareVersionScreen(), label: {
                            Text("Retry")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .foregroundColor(Color("PrimaryBlack"))
                                .background(Color("Action"))
                                .clipShape(Capsule())
                                .padding(.horizontal)
                        })
                        NavigationLink(destination: DeviceInfoScreen(), label: {
                            Text("Abort")
                                .frame(maxWidth: .infinity)                            .padding()
                                .foregroundColor(.white)
                                .background(Color("PrimaryBlack"))
                                .cornerRadius(30)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(Color.white, lineWidth: 1)
                                )
                                .padding(.horizontal)
                        })
                    }.padding(.top, 50)
                }
            }
        }.onAppear {
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
                progress += 1
                if progress >= 100 {
                    timer.invalidate()
                    installing = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                                            showSuccess = true
                                        }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct FirmwareUpdateScreen_Previews: PreviewProvider {
    static var previews: some View {
        FirmwareUpdateScreen()
    }
}
