//
//  MassifsView.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 10/02/2024.
//

import SwiftUI

struct MassifsView: View {

    @ObservedObject var viewModel: MassifsViewModel

    var body: some View {
        AsyncContentView(
            source: viewModel,
            loadingView: ProgressView()
        ) { massifs in
            List(massifs, id: \.properties.id) { massif in
                VStack {
                    Text(massif.properties.name.capitalized)
                        .foregroundStyle(UIColor(hex: massif.properties.colorHexa).swiftUiColor)

                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(massif.geometry.firstCoordinatesList, id: \.self) {
                                Text(String(format: "[%.3f, %.3f]", $0[0], $0[1]))
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    AppRouter.shared.createMassifsView()
}
