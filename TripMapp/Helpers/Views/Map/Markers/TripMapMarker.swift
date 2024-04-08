//
//  SearchResultMarker.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 09/04/2024.
//

import SwiftUI
import MapKit

struct TripMapMarker: MapContent {

    let viewModel: ViewModel

    var body: some MapContent {
        Marker(
            viewModel.name,
            systemImage: viewModel.systemImage,
            coordinate: viewModel.coordinates
        )
    }
}

#Preview {
    Map {
        TripMapMarker(viewModel: .init(
            refugeInfoResult: MockRefuges.refuges.first!.toLightPoint,
            type: .cottage
        ))
    }
}
