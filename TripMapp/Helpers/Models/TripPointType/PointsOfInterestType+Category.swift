//
//  PointsOfInterestCategory.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 03/04/2024.
//

import Foundation
import SwiftUI

extension TripPointType {
    /// Categories used to group PointsOfInterest Types
    enum Category: Int, CaseIterable {
        case hiking = 0
        case service
        case accommodation
    }
}

extension TripPointType.Category {
    var title: LocalizedStringKey {
        switch self {
        case .hiking: return "hiking_spots.title"
        case .service: return "services.title"
        case .accommodation: return "accommodations.title"
        }
    }

    var color: Color {
        switch self {
        case .hiking:
            return .orange
        case .service:
            return .blue
        case .accommodation:
            return .green
        }
    }

    var types: [TripPointType] {
        return TripPointType.allCases.filter { $0.category == self }
    }
}
extension TripPointType.Category: Identifiable {
    var id: Int { return rawValue }
}
