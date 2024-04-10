//
//  MassifPolygon.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 07/04/2024.
//

import SwiftUI
import MapKit

struct RefugesInfoMassifPolygon: MapContent {
    struct ViewModel {
        let id: Int
        let name: String
        let coordinates: [CLLocationCoordinate2D]
        let color: Color

        init(id: Int, name: String, coordinates: [CLLocationCoordinate2D], color: Color) {
            self.id = id
            self.name = name
            self.coordinates = coordinates
            self.color = color
        }

        init(massif: RefugesInfo.MassifPolygon) {
            self.id = massif.properties.id
            self.name = massif.properties.name
            self.coordinates = massif.geometry.coordinates2D
            self.color = UIColor(hex: massif.properties.colorHexa).swiftUiColor
        }
    }

    let viewModel: ViewModel

    var id: Int { return viewModel.id }

    // -------------------------------------------------------------------------
    // MARK: - Build Polygon
    // -------------------------------------------------------------------------

    var body: some MapContent {
        MapPolygon(coordinates: viewModel.coordinates)
            .foregroundStyle(viewModel.color.opacity(0.5))
            .stroke(viewModel.color, lineWidth: 3.0)

        Marker(
            viewModel.name,
            systemImage: "mountain.2",
            coordinate: viewModel.coordinates.calculateCentralPoint() ?? .zero
        )
        .tint(viewModel.color)
    }
}

#Preview {
    Map {
        RefugesInfoMassifPolygon(
            viewModel: .init(massif: MockMassifs.massifs.first!)
        )
    }
}
