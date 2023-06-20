//
//  ContentView.swift
//  Aeroh Link
//
//  Created by Tanishq Patidar on 15/06/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color(red: 0.06, green: 0.05, blue: 0.08).edgesIgnoringSafeArea(.all)
            VStack(spacing: 179) {
                VStack(spacing: 43) {
                    Spacer()
                    Image("AerohLinkIllustration")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 120.9)
                    
                    Text("Aeroh Link")
                        .foregroundColor(.white)
                        .font(.title)
                        .bold()
                    
                    Text("Make your home smarter with Aeroh Link")
                        .foregroundColor(Color(red: 0.75, green: 0.75, blue: 0.75))
                        .font(.body)
                        .bold()
                        .frame(width: 270)
                        .multilineTextAlignment(.center)
                }
                
                HStack(spacing: 23) {
                    Button(action: {
                        
                    }) {
                        Text("Sign up")
                            .frame(width: 110, height: 25)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color(red: 0.06, green: 0.05, blue: 0.08))
                            .cornerRadius(30)
                            .overlay(RoundedRectangle(cornerRadius: 30).stroke(Color.white, lineWidth: 1))
                            
                    }
                    Button(action: {
                        
                    }) {
                        Text("Login")
                            .frame(width: 110,height: 25)
                            .foregroundColor(Color(red: 0.06, green: 0.05, blue: 0.08))
                            .padding()
                            .background(Color(red: 1.00, green: 0.79, blue: 0.23))
                            .clipShape(Capsule())
                            
                    }
                }
//                .padding(.horizontal, 40)
            }
        }
        .overlay(SplashScreen())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

