//
//  TripMapPolyline+ViewModel.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 02/07/2024.
//

import Foundation
import MapKit
import SwiftUI

extension TripMapPolyline {

    struct ViewModel {
        let id: UUID
        let color: Color
        let coordinates: [CLLocationCoordinate2D]

        init(color: Color, coordinates: [CLLocationCoordinate2D]) {
            self.id = UUID()
            self.color = color
            self.coordinates = coordinates
        }
    }
}

extension TripMapPolyline.ViewModel {
    static var mocks: [Self] = [
        .init(
            color: .blue,
            coordinates: MockMassifs.massifs.first!.geometry.coordinates2D
        )
    ]
}
