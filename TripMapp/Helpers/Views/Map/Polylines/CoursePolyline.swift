//
//  GPXCoursePolyline.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 07/04/2024.
//

import SwiftUI
import MapKit
import Unicorp_GPXFile

struct CoursePolyline: MapContent {

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

    let viewModel: ViewModel

    var id: UUID { return viewModel.id }

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
        CoursePolyline(viewModel: .init(
            color: .blue,
            coordinates: MockMassifs.massifs.first!.geometry.coordinates2D
        ))
    }
}
