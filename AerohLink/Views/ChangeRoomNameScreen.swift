//
//  ChangeRoomNameScreen.swift
//  AerohLink
//
//  Created by Tanishq Patidar on 13/09/23.
//

import SwiftUI

struct ChangeRoomNameScreen: View {
    @State private var selectedRoomIndex = 0
    @State private var customRoomName = ""
    @State private var rooms = ["Living room", "Dining room", "Bedroom", "Guest room", "Kitchen", "Office", "Custom"]

    var body: some View {
        ZStack(alignment: .top) {
            Color("PrimaryBlack")
                .edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    Text("Room name:")
                        .foregroundColor(.white)
                    Spacer()
                    Picker("Room:", selection: $selectedRoomIndex) {
                        ForEach(0..<rooms.count, id: \.self) { index in
                            Text(rooms[index])
                        }
                    }
                    .pickerStyle(.menu)
                }
                .padding()

                if selectedRoomIndex == rooms.count - 1 {
                    TextField("Custom name", text: $customRoomName)
                        .disableAutocorrection(true)
                        .foregroundColor(.white)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color("SecondaryBlack"), lineWidth: 1)
                        )
                        .padding(.horizontal)
                }
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
        }
        .navigationTitle("Room name")
    }
}

struct ChangeRoomNameScreen_Previews: PreviewProvider {
    static var previews: some View {
        ChangeRoomNameScreen()
    }
}
