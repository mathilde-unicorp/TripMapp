//
//  RefugesInfo+BBox.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 12/02/2024.
//

import Foundation
import SwiftUI
import MapKit

extension RefugesInfo {

    enum Bbox: Codable {
        case world
        case coordinates(west: CGFloat, south: CGFloat, east: CGFloat, north: CGFloat)
    }
}

extension RefugesInfo.Bbox: CustomStringConvertible {
    /// BBox description, usable as a query parameter
    var description: String {
        switch self {
        case .world:
            return "world"
        case .coordinates(let west, let south, let east, let north):
            return String(
                format: "%.2f,%.2f,%.2f,%.2f", west, south, east, north
            )
        }
    }
}

extension RefugesInfo.Bbox {
    init?(mapCameraPosition: MapCameraPosition) {
        guard let region = mapCameraPosition.region else { return nil }
        self.init(region: region)
    }

    init?(region: MKCoordinateRegion) {
        let center = region.center
        let latitudeDiff = region.span.latitudeDelta / 2
        let longitudeDiff = region.span.longitudeDelta / 2

        self = RefugesInfo.Bbox.coordinates(
            west: center.longitude - longitudeDiff,
            south: center.latitude - latitudeDiff,
            east: center.longitude + longitudeDiff,
            north: center.latitude + latitudeDiff
        )
    }
}
