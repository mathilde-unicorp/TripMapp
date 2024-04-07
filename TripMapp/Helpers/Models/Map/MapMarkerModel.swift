//
//  MapMarkerModel.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 12/02/2024.
//

import Foundation
import SwiftUI
import MapKit

protocol MapMarkerModel: Identifiable {
    var id: Int { get }
    var name: String { get }
    var coordinates: CLLocationCoordinate2D { get }

    associatedtype MapMarkerContent: MapContent

    @MapContentBuilder
    func buildMarker() -> MapMarkerContent
}

//extension MapMarkerModel: Equatable {
//    static func == (lhs: Self, rhs: Self) -> Bool {
//        return lhs.id == rhs.id
//    }
//}
//
//extension MapMarkerModel: Hashable {
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(id)
//    }
//}

//extension MapMarkerModel {
//    init(refuge: RefugesInfo.LightRefugePoint) {
//        self.init(
//            id: refuge.properties.id,
//            name: refuge.properties.name,
//            coordinates: refuge.geometry.coordinate2D,
//            systemImage: refuge.properties.type.systemImage ?? ""
//        )
//    }
//}
