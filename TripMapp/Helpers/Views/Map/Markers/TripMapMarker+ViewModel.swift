//
//  SearchResultMarker+ViewModel.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 09/04/2024.
//

import Foundation
import MapKit
import SwiftUI

extension TripMapMarker {

    enum Source {
        case refugesInfo(refugeId: RefugeId)
        case mkMap(item: MKMapItem)
        case custom
    }

    struct ViewModel: Identifiable, Equatable {
        let id: UUID
        let source: Source
        let name: String
        let coordinates: CLLocationCoordinate2D
        let systemImage: String
        let color: Color
    }
}

extension TripMapMarker.ViewModel {
    static func == (lhs: TripMapMarker.ViewModel, rhs: TripMapMarker.ViewModel) -> Bool {
        return lhs.id == rhs.id
    }
}

// =============================================================================
// MARK: - Mocks
// =============================================================================

extension TripMapMarker.ViewModel {
    static var mocks: [Self] = [
        .init(refugeInfoResult: MockRefuges.refuges.first!.toLightPoint,
              type: .cottage),
        .init(mkMapItem: .init(placemark: .init(coordinate: .france)),
              type: .waypoint),
        .init(mkMapItem: .init(placemark: .init(coordinate: .giteDeLaColleStMichel)),
              type: .hotel)
    ]
}

// =============================================================================
// MARK: - ViewModel Initialization
// =============================================================================

extension TripMapMarker.ViewModel {

    init(
        source: TripMapMarker.Source,
        name: String,
        coordinates: CLLocationCoordinate2D,
        systemImage: String,
        color: Color
    ) {
        self.id = UUID()
        self.source = source
        self.name = name
        self.coordinates = coordinates
        self.systemImage = systemImage
        self.color = color
    }

    init(
        refugeInfoResult result: RefugesInfo.LightRefugePoint,
        type: PointsOfInterestType
    ) {
        self.init(
            source: .refugesInfo(refugeId: result.properties.id),
            name: result.properties.name,
            coordinates: result.geometry.coordinate2D,
            systemImage: type.systemImage,
            color: type.color
        )
    }

    init(
        mkMapItem: MKMapItem,
        type: PointsOfInterestType
    ) {
        self.init(
            source: .mkMap(item: mkMapItem),
            name: mkMapItem.name ?? "??",
            coordinates: mkMapItem.placemark.coordinate,
            systemImage: type.systemImage,
            color: type.color
        )
    }
}
