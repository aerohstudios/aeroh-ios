//
//  SplashScreen.swift
//  Aeroh Link
//
//  Created by Tanishq Patidar on 23/06/23.
//


import SwiftUI

struct SplashScreen: View {
    @State private var isActive = false
    @State private var size = 0.7
    @State private var opacity = 0.1

    var body: some View {
        // Only show the splash screen if isActive is false
        if !isActive {
            ZStack {
                // Background color
                Color(red: 1.00, green: 0.79, blue: 0.23)
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    Spacer()

                    // Logo Image
                    Image("logo-black")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150, height: 150) // Adjusted height value

                    Spacer()
                }
                .scaleEffect(size) // Apply scale effect to the VStack
                .opacity(opacity) // Apply opacity to the VStack
                .onAppear {
                    // Animate the scale effect and opacity
                                       withAnimation(.easeOut(duration: 1.2)) {
                                           self.size = 0.9
                                           self.opacity = 1.0
                                       }

                                    }
            }
            .onAppear {
                // Toggle the isActive state after a delay
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation(.linear(duration: 0.4)) {
                        isActive.toggle()
                    }
                }
            }
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
