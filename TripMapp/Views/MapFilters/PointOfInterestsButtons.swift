//
//  PointOfInterestsButtons.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 27/02/2024.
//

import SwiftUI
import MapKit

struct PointsOfInterestsButtons: View {
    var pointsOfInterests: [PointsOfInterestsCategory] = ServicesPointsOfInterests.allCases
    var onSelect: ((PointsOfInterestsCategory) -> Void)?

    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(pointsOfInterests, id: \.name) { pointOfInterest in
                    Button {
                        onSelect?(pointOfInterest)
                    } label: {
                        Label(
                            title: { Text(pointOfInterest.name).font(.caption) },
                            icon: { pointOfInterest.image }
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

#Preview {
    PointsOfInterestsButtons(
        onSelect: { _ in }
    )
}
