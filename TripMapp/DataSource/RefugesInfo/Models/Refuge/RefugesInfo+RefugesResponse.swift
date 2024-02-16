//
//  RIResponse.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 04/05/2023.
//

import Foundation

extension RefugesInfo {

    typealias LightRefugePoint = Feature<LightPoint, PointGeometry>
    typealias RefugePoint = Feature<Point, PointGeometry>

    struct RefugesPointResponse: Codable {
        let features: [RefugePoint]
    }

    struct RefugesLightPointResponse: Codable {
        let features: [LightRefugePoint]
    }
}
