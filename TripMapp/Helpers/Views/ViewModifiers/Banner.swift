//
//  Banner.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 05/05/2023.
//

import SwiftUI

struct Banner: ViewModifier {

    @Binding var isPresented: Bool

    var text: String
    var bannerType: BannerType

    func body(content: Content) -> some View {
        ZStack(alignment: .top) {
            content
            BannerView(isPresented: $isPresented, text: text, bannerType: bannerType)
        }
    }
}

extension View {
    func banner(isPresented: Binding<Bool>, text: String, type: BannerType, timeout: Double? = nil) -> some View {
        modifier(Banner(isPresented: isPresented, text: text, bannerType: type))
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
