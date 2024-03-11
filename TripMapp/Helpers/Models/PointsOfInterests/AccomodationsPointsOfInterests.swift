//
//  AccomodationsPointsOfInterests.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 05/03/2024.
//

import Foundation
import MapKit
import SwiftUI

enum AccomodationsPointsOfInterests: String, CaseIterable {
    case refuge
    case cottage
    case campground
    case hotel
    case bivouac
}

// -------------------------------------------------------------------------
// MARK: - Label
// -------------------------------------------------------------------------

extension AccomodationsPointsOfInterests: PointsOfInterestsCategory {
    var name: String {
        return self.rawValue.fromCamelCaseToNaturalWord.capitalized
    }

    var image: Image {
        switch self {
        case .refuge:
            return Image(systemName: "house.fill")
        case .cottage:
            return Image(systemName: "bed.double.fill")
        case .campground:
            return Image(systemName: "tent.2.fill")
        case .hotel:
            return Image(systemName: "building.fill")
        case .bivouac:
            return Image(systemName: "tent.fill")

        }
    }
}

// -------------------------------------------------------------------------
// MARK: - Preview
// -------------------------------------------------------------------------

#Preview {
    List(AccomodationsPointsOfInterests.allCases, id: \.self) { service in
        Label(
            title: { Text(service.name) },
            icon: { service.image }
        )
    }
}
