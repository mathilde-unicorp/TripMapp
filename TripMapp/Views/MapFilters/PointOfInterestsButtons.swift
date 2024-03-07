//
//  PointOfInterestsButtons.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 27/02/2024.
//

import SwiftUI
import MapKit

struct PointsOfInterestsButtons<Category: PointsOfInterestsCategory>: View {
    let title: String?
    let categories: [Category]
    let onSelect: ((Category) -> Void)?

    var body: some View {
        VStack(alignment: .leading) {
            if let title {
                Text(title)
                    .font(.headline)
            }

            ScrollView(.horizontal) {
                HStack {
                    ForEach(categories, id: \.name) { category in
                        Button {
                            onSelect?(category)
                        } label: {
                            Label(
                                title: { Text(category.name).font(.caption) },
                                icon: { category.image }
                            )
                        }
                    }
                }
                .buttonStyle(.borderedProminent)
                .labelStyle(.iconOnly)
            }
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    PointsOfInterestsButtons(
        title: "Services",
        categories: ServicesPointsOfInterests.allCases,
        onSelect: { _ in }
    )
}
