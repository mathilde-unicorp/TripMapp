//
//  RefugesInfo+MassifResponse.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 09/02/2024.
//

import Foundation

extension RefugesInfo {

    struct MassifsResponse {
        let features: [Feature<Polygon, MultiPolygonGeometry>]
    }

}
