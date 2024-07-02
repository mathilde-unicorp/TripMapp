//
//  GPXCoursePolyline.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 07/04/2024.
//

import SwiftUI
import MapKit
import Unicorp_GPXFile

struct TripMapPolyline: MapContent {

    let viewModel: ViewModel

    // -------------------------------------------------------------------------
    // MARK: - Body
    // -------------------------------------------------------------------------

    var body: some MapContent {
        MapPolyline(coordinates: viewModel.coordinates)
            .foregroundStyle(.clear)
            .stroke(viewModel.color, lineWidth: 3.0)
    }
}

#Preview {
    Map {
        TripMapPolyline(viewModel: TripMapPolyline.ViewModel.mocks.first!)
    }
}
