//
//  DeviceNamingScreen.swift
//  AerohLink
//
//  Created by Tanishq Patidar on 16/08/23.
//

import SwiftUI

struct DeviceNamingScreen: View {
    @State private var deviceName = ""
    @State private var selectedRoom: String?
    let roomTypes = ["Default", "Living Room", "Bedroom", "Study", "Dining room", "Office"]
    let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 1), count: 3)
    var body: some View {
        ZStack {
            Color("PrimaryBlack")
                .edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading) {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Device name")
                        .font(Font.custom("Poppins", size: 14))
                        .foregroundColor(Color("SecondaryWhite"))

                    TextField("Aeroh Link", text: $deviceName)
                        .foregroundColor(.white)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color("SecondaryBlack"), lineWidth: 1)
                        )
                }.padding()

                VStack(alignment: .leading, spacing: 10) {
                    Text("Select room")
                        .font(Font.custom("Poppins", size: 14))
                        .foregroundColor(Color("SecondaryWhite"))
                    LazyVGrid(columns: columns, spacing: 2) {
                        ForEach(roomTypes, id: \.self) { roomType in
                            Button(action: {
                                print(107)
                                selectedRoom = roomType
                                print(selectedRoom!)
                            }) {
                                HStack {
                                    if selectedRoom == roomType {
                                        Image(systemName: "checkmark.circle.fill")
                                            .font(.system(size: 12))
                                            .foregroundColor(.white)
                                    }
                                    Text(roomType)
                                        .font(.system(size: 12))
                                        .foregroundColor(selectedRoom == roomType ? .yellow : Color("SecondaryWhite"))
                                        .padding(.vertical, 0)
                                        .padding(.horizontal, 0)
                                }.padding()
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .cornerRadius(15)
                    .background(
                        RoundedRectangle(cornerRadius: 15, style: .continuous).fill(Color("SecondaryBlack"))
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .inset(by: 0.5)
                            .stroke(Color("SecondaryWhite"), lineWidth: 1)
                    )
                }.padding()
                Spacer()

                NavigationLink(destination: DeviceTypeSelectionScreen(), label: {
                        Text("Next")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(Color("PrimaryBlack"))
                            .background(Color("Action"))
                            .clipShape(Capsule())
                            .padding(.horizontal)
                })
            }  .navigationTitle("Remote info")
        }
    }
}

struct DeviceNamingScreen_Previews: PreviewProvider {
    static var previews: some View {
        DeviceNamingScreen()
    }
}
