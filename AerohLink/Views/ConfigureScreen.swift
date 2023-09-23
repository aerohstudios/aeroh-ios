//
//  ConfigureScreen.swift
//  AerohLink
//
//  Created by Tanishq Patidar on 22/09/23.
//

import SwiftUI

struct ConfigureScreen: View {
    @State private var selectedNavigationTag: Int?
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                Color("PrimaryBlack")
                    .edgesIgnoringSafeArea(.all)

                VStack(alignment: .center, spacing: 8) {
                    NavigationLink(
                        destination: RecordAndReplayScreen(),
                        tag: 1,
                        selection: $selectedNavigationTag,
                        label: {
                            EmptyView()
                        }
                    )
                    ZStack {
                        CustomButton(imageName: "powerIcon", buttonText: "Power") {
                            selectedNavigationTag = 1
                        }
                        ButtonEditLogo()
                    }

                    NavigationLink(
                        destination: RecordAndReplayScreen(),
                        tag: 2,
                        selection: $selectedNavigationTag,
                        label: {
                            EmptyView()
                        }
                    )
                    ZStack {
                        CustomButton(imageName: "speedIcon", buttonText: "Speed") {
                            selectedNavigationTag = 2
                        }
                        ButtonEditLogo()
                    }

                    NavigationLink(
                        destination: RecordAndReplayScreen(),
                        tag: 3,
                        selection: $selectedNavigationTag,
                        label: {
                            EmptyView()
                        }
                    )
                    ZStack {
                        CustomButton(imageName: "plusIcon", buttonText: "Temp up") {
                            selectedNavigationTag = 3
                        }
                        ButtonEditLogo()
                    }

                    NavigationLink(
                        destination: RecordAndReplayScreen(),
                        tag: 4,
                        selection: $selectedNavigationTag,
                        label: {
                            EmptyView()
                        }
                    )
                    ZStack {
                        CustomButton(imageName: "minusIcon", buttonText: "Temp down") {
                            selectedNavigationTag = 4
                        }
                        ButtonEditLogo()
                    }
                }
                .padding(.vertical)

                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        NavigationLink(destination: RecordAndReplayScreen()) {
                            Image(systemName: "plus")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20)
                                .foregroundColor(Color("PrimaryBlack"))
                                .padding()
                                .background(Color("Action"))
                                .clipShape(Circle())
                                .shadow(radius: 5)
                        }
                        .padding()
                    }
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: DeviceSettingsScreen()) {
                    Text("Done")
                }
            }
        }
        .navigationTitle("Aeroh Link")
        .navigationBarBackButtonHidden(true)
    }
}

struct ButtonEditLogo: View {
    var body: some View {
        Image(systemName: "pencil")
                            .foregroundColor(Color("White"))
                            .font(.system(size: 16))
                            .padding(5)
                            .background(Color("SecondaryBlack"))
                            .clipShape(Circle())
                            .offset(x: -175, y: -25)
    }
}

struct ConfigureScreen_Previews: PreviewProvider {
    static var previews: some View {
        ConfigureScreen()
    }
}
