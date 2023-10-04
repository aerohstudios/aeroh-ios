//
//  LazyView.swift
//  AerohLink
//
//  Created by Shiv Deepak on 10/4/23.
//

import SwiftUI

struct LazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    var body: some View {
        build()
    }
}
