//
//  GPXCoursePolyline.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 07/04/2024.
//

import SwiftUI
import MapKit
import Unicorp_GPXFile

struct GPXCoursePolyline: MapContent {
    
    struct ViewModel {
        let id: Int
        let color: Color

        let name: String
        let coordinates: [CLLocationCoordinate2D]

        init(id: Int, color: Color = .blue, gpxURL url: URL) {
            self.id = id
            self.color = color

            // Init coordinates from URL file
            let parser = GPXParser()

            guard let content = try? parser.parse(gpxFileURL: url) else {
                self.name = "--"
                self.coordinates = []
                return
            }

            self.coordinates = content.trackpoints.map { $0.coordinates }
            self.name = content.name ?? "--"
        }
    }

    let viewModel: ViewModel

    var id: Int { return viewModel.id }

    // -------------------------------------------------------------------------
    // MARK: - Body
    // -------------------------------------------------------------------------

    var body: some MapContent {
        MapPolyline(coordinates: viewModel.coordinates)
            .foregroundStyle(.clear)
            .stroke(viewModel.color, lineWidth: 3.0)

        if let firstCoordinates = viewModel.coordinates.first {
            Marker(coordinate: firstCoordinates) {
                Label(viewModel.name, systemImage: "figure.walk")
            }
        }
    }
}

#Preview {
    Map {
        GPXCoursePolyline(viewModel: .init(id: 0, gpxURL: .gr66Gpx))
    }
}
