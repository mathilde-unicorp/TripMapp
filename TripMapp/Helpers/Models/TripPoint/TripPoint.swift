//
//  TripPoint.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 18/07/2024.
//

import SwiftUI
import MapKit

struct TripPoint: Identifiable, Equatable {
    let id: String
    let source: TripPoint.Source
    let sourceId: String?
    let name: String
    let shortDescription: String
    let coordinates: CLLocationCoordinate2D
    let systemImage: String
    let color: Color

    let pointType: TripPointType?
}

extension TripPoint {
    static func == (lhs: TripPoint, rhs: TripPoint) -> Bool {
        return lhs.id == rhs.id
    }
}

// =============================================================================
// MARK: - Mocks
// =============================================================================

extension TripPoint {
    static var mocks: [Self] = [
        .build(from: MockRefuges.refuges.first!.toLightPoint),
        .build(from: MKMapItem(placemark: .init(coordinate: .france)), type: .waypoint),
        .build(from: MKMapItem(placemark: .init(coordinate: .giteDeLaColleStMichel)), type: .hotel)
    ]
}
