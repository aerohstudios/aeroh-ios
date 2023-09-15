//
//  DeviceTypeSelectionScreen.swift
//  AerohLink
//
//  Created by Tanishq Patidar on 11/09/23.
//

import SwiftUI

struct DeviceTypeSelectionScreen: View {
    @State private var selectedSquareIndex: Int?
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                Color("PrimaryBlack")
                    .edgesIgnoringSafeArea(.all)
                VStack(alignment: .leading, spacing: 20) {
                    HStack(spacing: 20) {
                        SquareComponent(icon: Image(systemName: "tv.fill"), text: "TV", color: Color("SecondaryBlack"), isSelected: selectedSquareIndex == 0)
                            .onTapGesture {
                                selectedSquareIndex = 0
                            }
                        SquareComponent(icon: Image(systemName: "tv.and.mediabox"), text: "Set-top box", color: Color("SecondaryBlack"), isSelected: selectedSquareIndex == 1)
                            .onTapGesture {
                                selectedSquareIndex = 1
                            }
                        SquareComponent(icon: Image(systemName: "fanblades.fill"), text: "AC", color: Color("SecondaryBlack"), isSelected: selectedSquareIndex == 2)
                            .onTapGesture {
                                selectedSquareIndex = 2
                            }
                    }
                    HStack(spacing: 20) {
                        SquareComponent(icon: Image(systemName: "fan.floor.fill"), text: "Fan", color: Color("SecondaryBlack"), isSelected: selectedSquareIndex == 3)
                            .onTapGesture {
                                selectedSquareIndex = 3
                            }
                        SquareComponent(icon: Image(systemName: "appletv.fill"), text: "Smart box", color: Color("SecondaryBlack"), isSelected: selectedSquareIndex == 4)
                            .onTapGesture {
                                selectedSquareIndex = 4
                            }
                        SquareComponent(icon: Image(systemName: "hifispeaker.2.fill"), text: "A/V receiver", color: Color("SecondaryBlack"), isSelected: selectedSquareIndex == 5)
                            .onTapGesture {
                                selectedSquareIndex = 5
                            }
                    }
                    HStack(spacing: 20) {
                        SquareComponent(icon: Image(systemName: "externaldrive.fill"), text: "DVD player", color: Color("SecondaryBlack"), isSelected: selectedSquareIndex == 6)
                            .onTapGesture {
                                selectedSquareIndex = 6
                            }
                        SquareComponent(icon: Image(systemName: "videoprojector.fill"), text: "Projector", color: Color("SecondaryBlack"), isSelected: selectedSquareIndex == 7)
                            .onTapGesture {
                                selectedSquareIndex = 7
                            }
                        SquareComponent(icon: Image(systemName: "camera.fill"), text: "Camera", color: Color("SecondaryBlack"), isSelected: selectedSquareIndex == 8)
                            .onTapGesture {
                                selectedSquareIndex = 8
                            }
                    }
                    HStack(alignment: .top, spacing: 20) {
                        SquareComponent(icon: Image(systemName: "plus.circle.fill"), text: "Custom", color: Color("SecondaryBlack"), isSelected: selectedSquareIndex == 9)
                            .onTapGesture {
                                selectedSquareIndex = 9
                            }
                    }
                }.padding()
            }
        }.navigationTitle("Aeroh Link Setup")
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct SquareComponent: View {
    var icon: Image
    var text: String
    var color: Color
    var isSelected: Bool

    var body: some View {
NavigationLink(destination: DeviceControlScreen(), label: {
    VStack {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(color)
                .frame(width: 100, height: 100)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.yellow, lineWidth: isSelected ? 1 : 0)
                )
            if isSelected {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.yellow)
                                    .font(.system(size: 20))
                                    .offset(x: -35, y: -35)
                            }
            VStack {
                icon
                    .resizable()
                    .foregroundColor(.white)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 32, height: 32)
                    .padding(5)
                Text(text)
                    .font(.system(size: 14))
                    .foregroundColor(Color("SecondaryWhite"))
            }
        }
    }
})
    }
}

struct DeviceTypeSelectionScreen_Previews: PreviewProvider {
    static var previews: some View {
        DeviceTypeSelectionScreen()
    }
}
