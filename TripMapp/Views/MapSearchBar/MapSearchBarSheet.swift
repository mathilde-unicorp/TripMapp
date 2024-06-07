//
//  MapSearchBarSheet.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 15/05/2024.
//

import SwiftUI

struct MapSearchBarSheet: View {
    var body: some View {
        VStack {
            Spacer()

            MapSearchBar()
                .background(.thinMaterial)
                .clipShape(UnevenRoundedRectangle(
                    cornerRadii: .init(topLeading: 20.0, topTrailing: 20.0)
                ))
        }
    }
}

#Preview {
    MapSearchBarSheet()
}
