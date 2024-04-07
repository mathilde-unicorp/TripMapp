//
//  MassifModel.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 12/02/2024.
//

import Foundation
import MapKit
import SwiftUI

protocol MapPolygonModel: Identifiable, Equatable, Hashable {
    var id: UUID { get }
    var name: String { get set }
    var coordinates: [CLLocationCoordinate2D] { get set }
    var color: Color { get set }
}

//extension MapPolygonModel {
//    init(massif: RefugesInfo.MassifPolygon) {
//        self.init(
//            id: massif.properties.id,
//            name: massif.properties.name,
//            coordinates: massif.geometry.coordinates2D,
//            color: UIColor(hex: massif.properties.colorHexa).swiftUiColor
//        )
//    }
//}
