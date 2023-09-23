//
//  RecordAndReplayScreen.swift
//  AerohLink
//
//  Created by Tanishq Patidar on 22/09/23.
//

import SwiftUI

struct RecordAndReplayScreen: View {
    @State var startAnimation = false
    @State var pulse1 = false
    @State var pulse2 = false
    @State var pulse3 = false
    @State var signalRecieved = false
    @State var buttonName = ""
    @State private var rooms = ["Toggle", "Steper"]
    @State private var selectedRoomIndex = 0
    var body: some View {
        ZStack(alignment: .center) {
            Color("PrimaryBlack")
                .edgesIgnoringSafeArea(.all)
            if signalRecieved {
                VStack(spacing: 30) {
                    Spacer()
                    Image("AerohLinkIllustration")
                        .resizable()
                        .aspectRatio(contentMode: .fit).frame(maxWidth: 400)
                        .padding([.leading, .trailing], 80)
                      .foregroundColor(Color("SecondaryWhite"))
                    Text("Aeroh link recieved a signal")
                      .font(
                        Font.system(size: 24)
                          .weight(.bold)
                      )
                      .foregroundColor(.white)
                    VStack(spacing: 20) {
                        HStack {
                            RoundedRectangle(cornerRadius: 15)
                                .frame(width: 351, height: 72)
                                .padding()
                                .overlay {
                                    HStack {
                                        Text("Button type:")
                                          .font(Font.custom("Poppins", size: 16))
                                          .foregroundColor(.white)
                                        Spacer()
                                        Picker("Room:", selection: $selectedRoomIndex) {
                                            ForEach(0..<rooms.count, id: \.self) { index in
                                                Text(rooms[index])
                                            }
                                        }
                                        .pickerStyle(.menu)
                                    }.padding(.horizontal, 40)
                                }
                        }.foregroundColor(Color("SecondaryBlack"))
                            .padding(.horizontal)
                        VStack(alignment: .leading) {
                            Text("Button Name")
                              .font(Font.system(size: 14))
                              .foregroundColor(Color(red: 0.75, green: 0.75, blue: 0.75))
                              .padding(.horizontal)
                            TextField("", text: $buttonName)
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                                .foregroundColor(.white)
                                .padding()
                                .overlay(
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(Color("SecondaryBlack"), lineWidth: 1)
                                )
                                .padding(.horizontal)
                                .colorScheme(.dark)
                        }.padding(.horizontal)
                    }
                    Spacer()
                    HStack(spacing: 20) {
                        Button(action: {
                            signalRecieved = false
                        }, label: {
                            Text("Retry")
                                .frame(maxWidth: .infinity, minHeight: 25)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color("PrimaryBlack"))
                                .cornerRadius(30)
                                .overlay(RoundedRectangle(cornerRadius: 30).stroke(Color.white, lineWidth: 1))

                        })
                        NavigationLink(destination: DeviceSettingsScreen(), label: {
                            Text("Save")
                                .frame(maxWidth: .infinity, minHeight: 25)
                                .foregroundColor(Color("PrimaryBlack"))
                                .padding()
                                .background(Color("Action"))
                                .clipShape(Capsule())
                        })

                    }.padding(.horizontal, 50)
                }
            } else {
                VStack(spacing: 50) {
                    Image("AerohLinkIllustration")
                        .resizable()
                        .aspectRatio(contentMode: .fit).frame(maxWidth: 400)
                        .padding([.leading, .trailing], 80)
                    Text("When the light changes, give a signal from your device remote to aeroh link")
                      .font(
                        Font.system(size: 16)
                          .weight(.semibold)
                      )
                      .multilineTextAlignment(.center)
                      .foregroundColor(Color("SecondaryWhite"))
                    Text("Waiting for signal...")
                      .font(
                        Font.system(size: 24)
                          .weight(.bold)
                      )
                      .foregroundColor(.white)
                    ZStack {
                        Circle()
                            .stroke(Color("Error").opacity(0.6))
                            .frame(width: 123, height: 123)
                            .scaleEffect(pulse1  ? 2.8 : 0)
                            .opacity(pulse1 ? 1 : 0)
                        Circle()
                            .stroke(Color("Error").opacity(0.6))
                            .frame(width: 123, height: 123)
                            .scaleEffect(pulse2  ? 2.8 : 0)
                            .opacity(pulse2 ? 1 : 0)
                        Circle()
                            .stroke(Color("Error").opacity(0.6))
                            .frame(width: 123, height: 123)
                            .scaleEffect(pulse3  ? 2.8 : 0)
                            .opacity(pulse3 ? 1 : 0)
                        Circle()
                            .fill(
                                EllipticalGradient(
                                stops: [
                                Gradient.Stop(color: Color(red: 1, green: 0.78, blue: 0.23).opacity(0.71), location: 0.00),
                                Gradient.Stop(color: Color(red: 0.55, green: 0.09, blue: 0.09), location: 1.00)
                                ],
                                center: UnitPoint(x: 0.5, y: 0.5)
                                ))
                            .frame(width: 123, height: 123)
                            .shadow(color: Color.black.opacity(0.07), radius: 5, x: 5, y: 5)
                            .overlay {
                                ForEach(1..<13) { index in
                                                let circleSize = CGFloat(10 * index)
                                                Circle()
                                                    .stroke(Color(red: 1, green: 0.78, blue: 0.23).opacity(0.5))
                                                    .frame(width: circleSize, height: circleSize)
                                            }
                            }
                    }.padding(.top, 100)
                }
            }

        }.onAppear {
            animateView()
        }
        .navigationTitle("Record and Replay")
    }
    func animateView() {
        withAnimation(Animation.linear(duration: 2.4).repeatForever(autoreverses: false), {
            startAnimation.toggle()
        })
        withAnimation(Animation.linear(duration: 2.4).delay(0.5).repeatForever(autoreverses: false), {
            pulse1.toggle()
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            withAnimation(Animation.linear(duration: 2.4).delay(0.5).repeatForever(autoreverses: false), {
                pulse2.toggle()
            })

        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            withAnimation(Animation.linear(duration: 2.4).delay(0.5).repeatForever(autoreverses: false), {
                pulse3.toggle()
            })

        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 8, execute: {
            withAnimation(Animation.linear(duration: 1.7).delay(0.5), {
                signalRecieved = true
            })

        })
    }
}

struct RecordAndReplayScreen_Previews: PreviewProvider {
    static var previews: some View {
        RecordAndReplayScreen()
    }
}
