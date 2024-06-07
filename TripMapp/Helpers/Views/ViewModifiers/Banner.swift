//
//  Banner.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 05/05/2023.
//

import SwiftUI

extension View {
    /// Display a banner over the top of the current view, displaying a message using the `type`.
    /// It can be dismissed manually of with a timeout (which i don't recommend)
    func banner(isPresented: Binding<Bool>, text: String, type: BannerType, timeout: Double? = nil) -> some View {
        self.overlay(alignment: .top) {
            BannerView(isPresented: isPresented, text: text, bannerType: type)
        }
    }
}

struct Banner_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            VStack {
                Text("_example_hello_world")
            }
            .setFullHeight(alignment: .center)
        }
        .banner(isPresented: .constant(true), text: "Do you know ?", type: .information)
    }
}
