//
//  TripPoint+build.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 18/07/2024.
//

import Foundation
import MapKit

// =============================================================================
// MARK: - Build from RefugesInfo
// =============================================================================

extension TripPoint {

    static func build(
        from refugeInfoResult: RefugesInfo.LightRefugePoint
    ) -> Self {
        let type = TripPointType(refugesInfoPointType: refugeInfoResult.properties.type) ?? .refuge

        return .init(
            id: "\(refugeInfoResult.properties.id)",
            source: .refugesInfo,
            sourceId: refugeInfoResult.properties.id.toString,
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
}

// =============================================================================
// MARK: - Build from MKMapItem
// =============================================================================

extension TripPoint {

    static func build(
        from mkMapItem: MKMapItem,
        type: TripPointType
    ) -> Self {
        .init(
            id: UUID().uuidString,
            source: .mkMap,
            sourceId: nil,
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

// =============================================================================
// MARK: - Build from TripPointEntity
// =============================================================================

extension TripPoint {
    static func build(from entity: TripPointEntity) -> TripPoint {
        let pointType = entity.tripPointType

        return self.init(
            id: (entity.id ?? UUID()).uuidString,
            source: TripPoint.Source(rawValue: entity.source ?? "") ?? .custom,
            sourceId: entity.sourceId,
            name: entity.name ?? "",
            shortDescription: "",
            coordinates: .init(latitude: entity.latitude, longitude: entity.longitude),
            systemImage: pointType?.systemImage ?? "mappin",
            color: pointType?.color ?? .red,
            pointType: pointType
        )
    }
}
