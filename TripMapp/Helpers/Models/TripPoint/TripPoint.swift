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

// =============================================================================
// MARK: - Build
// =============================================================================

extension TripPoint {

    // -------------------------------------------------------------------------
    // MARK: - RefugesInfo
    // -------------------------------------------------------------------------

    static func build(
        from refugeInfoResult: RefugesInfo.LightRefugePoint
    ) -> Self {
        let type = TripPointType(refugesInfoPointType: refugeInfoResult.properties.type) ?? .refuge

        return .init(
            id: "\(refugeInfoResult.properties.id)",
            source: .refugesInfo(refugeId: refugeInfoResult.properties.id),
            name: refugeInfoResult.properties.name,
            shortDescription: shortDescription(from: refugeInfoResult, type: type),
            coordinates: refugeInfoResult.geometry.coordinate2D,
            systemImage: type.systemImage,
            color: type.color,
            pointType: type
        )
    }

    private static func shortDescription(
        from refugeInfoResult: RefugesInfo.LightRefugePoint,
        type: TripPointType
    ) -> String {
        let altitude = refugeInfoResult.properties.coordinates.altitude
        let altitudeDesc = String(localized: "altitude_description \(altitude)m")

        var capacityDesc: String = ""
        if let capacity = refugeInfoResult.properties.capacity {
            capacityDesc = "\(capacity.name): \(capacity.value?.toString ?? "--")"
        }

        switch type {
        case .summit, .waypoint, .water, .lake:
            return altitudeDesc
        case .refuge, .cottage, .hut, .campground, .bivouac:
            return [altitudeDesc, capacityDesc].joined(separator: "\n")
        default: return ""
        }
    }

    // -------------------------------------------------------------------------
    // MARK: - MKMapItem
    // -------------------------------------------------------------------------

    static func build(
        from mkMapItem: MKMapItem,
        type: TripPointType
    ) -> Self {
        .init(
            id: UUID().uuidString,
            source: .mkMap(item: mkMapItem),
            name: mkMapItem.name ?? "??",
            shortDescription: mkMapItem.placemark.shortLocationAddress,
            coordinates: mkMapItem.placemark.coordinate,
            systemImage: type.systemImage,
            color: type.color,
            pointType: type
        )
    }

    static func buildMarkers(
        from refugeInfoResults: [RefugesInfo.LightRefugePoint]
    ) -> [Self] {
        return refugeInfoResults.map { .build(from: $0) }
    }

    static func buildMarkers(
        from mkMapItems: [MKMapItem],
        type: TripPointType
    ) -> [Self] {
        return mkMapItems.map { .build(from: $0, type: type) }
    }
}
