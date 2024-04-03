//
//  PointsOfInterestCategory.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 03/04/2024.
//

import Foundation
import SwiftUI

/// Categories used to group PointsOfInterest Types
enum PointsOfInterestCategory: Int, CaseIterable {
    case hiking = 0
    case service
    case accommodation

    var title: LocalizedStringKey {
        switch self {
        case .hiking: return "hiking_spots.title"
        case .service: return "services.title"
        case .accommodation: return "accommodations.title"
        }
    }

    var types: [POIType] {
        return POIType.allCases.filter { $0.category == self }
    }
}

extension PointsOfInterestCategory: Identifiable {
    var id: Int { return rawValue }
}
