//
//  RefugesInfoMarker.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 07/04/2024.
//

import SwiftUI
import MapKit

struct RefugesInfoMarker: MapContent {

    struct ViewModel: Identifiable {
        let id: UUID
        let refugeId: Int
        let name: String
        let coordinates: CLLocationCoordinate2D
        let systemImage: String

        init(refugeId: Int, name: String, coordinates: CLLocationCoordinate2D, systemImage: String) {
            self.id = UUID()
            self.refugeId = refugeId
            self.name = name
            self.coordinates = coordinates
            self.systemImage = systemImage
        }

        init(refugeInfoResult result: RefugesInfo.LightRefugePoint) {
            self.init(
                refugeId: result.properties.id,
                name: result.properties.name,
                coordinates: result.geometry.coordinate2D,
                systemImage: result.properties.type.systemImage ?? ""
            )
        }
    }

    let viewModel: ViewModel

    var id: UUID { return viewModel.id }

    // -------------------------------------------------------------------------
    // MARK: - Body
    // -------------------------------------------------------------------------
    
    var body: some MapContent {
        Marker(viewModel.name, systemImage: viewModel.systemImage, coordinate: viewModel.coordinates)
    }
}

#Preview {
    Map {
        RefugesInfoMarker(
            viewModel: .init(refugeInfoResult: MockRefuges.refuges.first!.toLightPoint)
        )
    }
}
