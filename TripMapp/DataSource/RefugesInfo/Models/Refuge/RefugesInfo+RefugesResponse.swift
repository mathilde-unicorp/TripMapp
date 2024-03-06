//
//  RIResponse.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 04/05/2023.
//

import Foundation

extension RefugesInfo {

    // -------------------------------------------------------------------------
    // MARK: - Reguge Point
    // -------------------------------------------------------------------------

    typealias RefugePoint = Feature<Point, PointGeometry>

    struct RefugesPointResponse: Codable {
        let features: [RefugePoint]
    }

    // -------------------------------------------------------------------------
    // MARK: - Light Refuge Point
    // -------------------------------------------------------------------------

    typealias LightRefugePoint = Feature<LightPoint, PointGeometry>

    struct RefugesLightPointResponse: Codable {
        let features: [LightRefugePoint]
    }
}

// =============================================================================
// MARK: - Conversions
// =============================================================================

extension RefugesInfo.RefugePoint {
    var toLightPoint: RefugesInfo.LightRefugePoint {
        RefugesInfo.LightRefugePoint(
            properties: .init(
                id: self.properties.id,
                name: self.properties.name,
                type: self.properties.type
            ),
            geometry: self.geometry
        )
    }
}
