//
//  MapSearchTripPointTypeSectionHeader.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 26/06/2024.
//

import SwiftUI

struct MapSearchTripPointTypeSectionHeader: View {
    var onShowMore: () -> Void

    var body: some View {
        HStack {
            Text("points_of_interest.title")
                .foregroundStyle(UIColor.secondaryLabel.swiftUiColor)

            Spacer()

            Button("show_more", action: onShowMore)
        }
        .font(.subheadline)
    }
}

#Preview {
    MapSearchTripPointTypeSectionHeader(onShowMore: { print("show more") })
}
