//
//  RefugesInfo+MassifsResponse.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 09/02/2024.
//

import Foundation

extension RefugesInfo {

    typealias MassifPolygon = Feature<Polygon, MultiPolygonGeometry>

    struct MassifsResponse: Codable {
        let features: [MassifPolygon]
    }

}
