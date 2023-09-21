//
//  LoadingView.swift
//  AerohLink
//
//  Created by Tanishq Patidar on 21/09/23.
//

import SwiftUI

struct LoadingView: View {
    @State private var rotation: Double = 0
    let text: String

    init(text: String) {
        self.text = text
    }

    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 2)
                .opacity(0.8)
                .foregroundColor(Color("Action"))
            Circle()
                .trim(from: 0, to: 0.75)
                .stroke(style: StrokeStyle(lineWidth: 2,
                                           lineCap: .round, lineJoin: .round))
                .foregroundColor(Color("SecondaryBlack"))
                .rotationEffect(.degrees(rotation))
                .animation(.linear(duration: 1).repeatForever(autoreverses: false), value: rotation)
                .onAppear {
                    self.rotation = 360
                }
            Text(text)
                .font(Font.custom("Inter", size: 32))
                .foregroundColor(Color(red: 0.75, green: 0.75, blue: 0.75))
        }
        .compositingGroup()
        .frame(width: 245)
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(text: "Requested")
    }
}
