//
//  SplashScreen.swift
//  Aeroh Link
//
//  Created by Tanishq Patidar on 16/06/23.
//

import SwiftUI

struct SplashScreen: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        if !isActive {
            ZStack {
                Color(red: 1.00, green: 0.79, blue: 0.23).edgesIgnoringSafeArea(.all)
                VStack {
                    Spacer()
                    Image("logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150, height: 150) // Adjusted height value
                    Spacer()
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 1.2)) {
                        self.size = 0.9
                        self.opacity = 1.0
                    }
                }
            }
            .onAppear {
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
