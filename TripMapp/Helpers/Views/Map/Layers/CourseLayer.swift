//
//  CourseLayer.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 08/04/2024.
//

import SwiftUI
import MapKit
import Unicorp_GPXFile

struct CourseLayer: MapContent {

    struct ViewModel {
        let id: UUID
        let name: String
        let polyline: CoursePolyline.ViewModel
        let markers: [TripMapMarker.ViewModel]

        init(gpxUrl: URL) {
            self.id = UUID()

            // Init coordinates from URL file
            let parser = GPXParser()

            guard let content = try? parser.parse(gpxFileURL: gpxUrl) else {
                self.name = "--"
                self.polyline = .init(color: .blue, coordinates: [])
                self.markers = []
                return
            }

            self.name = content.name ?? "--"
            self.polyline = .init(
                color: .blue,
                coordinates: content.trackpoints.map { $0.coordinates }
            )
            self.markers = content.waypoints.map {
                .init(mkMapItem: .init(placemark: .init(coordinate: $0.coordinates)),
                      type: .waypoint)
            }
        }
    }

    let viewModel: ViewModel

    // -------------------------------------------------------------------------
    // MARK: - Body
    // -------------------------------------------------------------------------

    var body: some MapContent {
        CoursePolyline(viewModel: viewModel.polyline)

        if let firstCoordinates = viewModel.polyline.coordinates.first {
            Marker(coordinate: firstCoordinates) {
                Label(viewModel.name, systemImage: "figure.walk")
            }
        }

        MarkersLayer(markers: .constant(viewModel.markers))
    }
}

#Preview {
    Map {
        CourseLayer(viewModel: .init(gpxUrl: .gr66Gpx))
    }
}
