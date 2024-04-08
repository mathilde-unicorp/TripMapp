//
//  SearchResultMarker+ViewModel.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 09/04/2024.
//

import Foundation
import MapKit

extension TripMapMarker {

    enum Source {
        case refugesInfo(refugeId: RefugeId)
        case mkMap(item: MKMapItem)
    }

    struct ViewModel: Identifiable, Equatable {
        let id: UUID
        let source: Source
        let name: String
        let coordinates: CLLocationCoordinate2D
        let systemImage: String

        init(source: Source, name: String, coordinates: CLLocationCoordinate2D, systemImage: String) {
            self.id = UUID()
            self.source = source
            self.name = name
            self.coordinates = coordinates
            self.systemImage = systemImage
        }

        init(refugeInfoResult result: RefugesInfo.LightRefugePoint, type: PointsOfInterestType) {
            self.init(
                source: .refugesInfo(refugeId: result.properties.id),
                name: result.properties.name,
                coordinates: result.geometry.coordinate2D,
                systemImage: type.systemImage
            )
        }

        init(mkMapItem: MKMapItem, type: PointsOfInterestType) {
            self.init(
                source: .mkMap(item: mkMapItem),
                name: mkMapItem.name ?? "??",
                coordinates: mkMapItem.placemark.coordinate,
                systemImage: type.systemImage)
        }

    }
}

extension TripMapMarker.ViewModel {
    static func == (lhs: TripMapMarker.ViewModel, rhs: TripMapMarker.ViewModel) -> Bool {
        return lhs.id == rhs.id
    }
}
