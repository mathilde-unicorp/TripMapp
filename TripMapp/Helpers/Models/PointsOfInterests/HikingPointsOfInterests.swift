//
//  ShopsPointsOfInterests.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 11/03/2024.
//

import Foundation
import SwiftUI
import MapKit

enum HikingPointsOfInterests: String, CaseIterable {
    case summit
    case waypoints
    case water
    case lake
}

extension HikingPointsOfInterests: PointsOfInterestsCategory {
    var name: String {
        return self.rawValue.fromCamelCaseToNaturalWord.capitalized
    }

    var image: Image {
        switch self {
        case .summit:
            return Image(systemName: "mountain.2.fill")
        case .waypoints:
            return Image(systemName: "mappin")
        case .water:
            return Image(systemName: "drop.fill")
        case .lake:
            return Image(systemName: "figure.open.water.swim")
        }
    }

    var defaultQuery: String {
        return "" // Not applicable
    }

    var mkPointOfInterestFilter: MKPointOfInterestFilter {
        return .init(including: []) // Not applicable
    }
}

#Preview {
    List(HikingPointsOfInterests.allCases, id: \.self) { service in
        Label(
            title: { Text(service.name) },
            icon: { service.image }
        )
    }
}
