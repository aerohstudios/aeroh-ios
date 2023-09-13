//
//  DeviceInfoScreen.swift
//  AerohLink
//
//  Created by Tanishq Patidar on 13/09/23.
//

import SwiftUI

struct DeviceInfoRow: View {
    let title: String
    let detail: String
    let destination: AnyView?
    let showDivider: Bool
    let showNavigation: Bool

    var body: some View {
        VStack {
            if showNavigation {
                NavigationLink(destination: destination ?? AnyView(DeviceControlScreen())) {
                    rowContent
                }
            } else {
                rowContent
            }
            if showDivider {
                Divider()
                    .frame(height: 1)
                    .overlay(Color(red: 0.16, green: 0.16, blue: 0.16))
            }
        }
    }

    private var rowContent: some View {
        HStack {
            Text(title)
                .foregroundColor(.white)
            Spacer()
            Text(detail)
                .foregroundColor(Color(red: 0.75, green: 0.75, blue: 0.75))
            if showNavigation {
                Image("greyArrowIcon")
                    .resizable()
                    .frame(width: 16, height: 16)
            }
        }
    }
}

struct DeviceInfoScreen: View {
    var body: some View {
        ZStack(alignment: .top) {
            Color(red: 0.06, green: 0.05, blue: 0.08)
                .edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading, spacing: 15) {

                DeviceInfoRow(title: "Device name:", detail: "Aeroh Link", destination: AnyView(DeviceRenameScreen()), showDivider: true, showNavigation: true)

                DeviceInfoRow(title: "Room name:", detail: "Living room", destination: AnyView(ChangeRoomNameScreen()), showDivider: true, showNavigation: true)

                DeviceInfoRow(title: "Device type:", detail: "AC", destination: AnyView(ChangeDeviceTypeScreen()), showDivider: true, showNavigation: true)

                DeviceInfoRow(title: "Firmware version:", detail: "1.3.1", destination: AnyView(DeviceControlScreen()), showDivider: true, showNavigation: true)

                DeviceInfoRow(title: "Mac address:", detail: "12:AB:34:CD:56:EF", destination: nil, showDivider: true, showNavigation: false)

                DeviceInfoRow(title: "Device model:", detail: "Aeroh Link", destination: nil, showDivider: true, showNavigation: false)

                DeviceInfoRow(title: "IP address:", detail: "192.168.2.1", destination: nil, showDivider: false, showNavigation: false)

            }
            .padding()
        }.navigationTitle("Settings")
    }
}

struct DeviceInfoScreen_Previews: PreviewProvider {
    static var previews: some View {
        DeviceInfoScreen()
    }
}
