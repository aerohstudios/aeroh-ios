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
            Color(red: 0.06, green: 0.05, blue: 0.08)
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
                                .stroke(Color(red: 0.16, green: 0.16, blue: 0.16), lineWidth: 1)
                        )
                        .padding(.horizontal)
                }
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
        }
        .navigationTitle("Room name")
    }
}

struct ChangeRoomNameScreen_Previews: PreviewProvider {
    static var previews: some View {
        ChangeRoomNameScreen()
    }
}
