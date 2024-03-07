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
}

// -------------------------------------------------------------------------
// MARK: - Map
// -------------------------------------------------------------------------

extension AccomodationsPointsOfInterests: PointsOfInterestsCategory {
    var defaultQuery: String {
        switch self {
        case .refuge:
            return "refuge"
        case .cottage:
            return "gite d'étape"
        case .campground:
            return "camping"
        case .hotel:
            return "hotel"
        }
    }
    
    var mkPointOfInterestFilter: MKPointOfInterestFilter {
        return .init(including: mkPointsOfInterestCategory)
    }
    
    var mkPointsOfInterestCategory: [MKPointOfInterestCategory] {
        switch self {
        case .refuge:
            return []
        case .cottage:
            return []
        case .campground:
            return [.campground]
        case .hotel:
            return [.hotel]
        }
    }
}

// -------------------------------------------------------------------------
// MARK: - Label
// -------------------------------------------------------------------------

extension AccomodationsPointsOfInterests {
    var name: String {
        return self.rawValue.fromCamelCaseToNaturalWord.capitalized
    }

    var image: Image {
        switch self {
        case .refuge:
            return Image(systemName: "house.fill")
        case .cottage:
            return Image(systemName:  "bed.double.fill")
        case .campground:
            return Image(systemName: "tent.fill")
        case .hotel:
            return Image(systemName: "building.fill")
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
