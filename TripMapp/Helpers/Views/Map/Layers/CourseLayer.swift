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
        let polyline: TripMapPolyline.ViewModel
        let markers: [TripPoint]

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

            // Build Polyline

            self.polyline = .init(
                color: .blue,
                coordinates: content.trackpoints.map { $0.coordinates }
            )

            // Build Markers

            var tempMarkers = content.waypoints.map {
                TripPoint.build(
                    from: .init(placemark: .init(coordinate: $0.coordinates)),
                    type: .waypoint
                )
            }

            if let polylineStart = polyline.coordinates.first {
                let marker = TripPoint(
                    id: UUID().uuidString,
                    source: .custom,
                    sourceId: nil,
                    name: "Départ de \(name)",
                    shortDescription: "",
                    coordinates: polylineStart,
                    systemImage: "flag.fill",
                    color: .label,
                    pointType: nil
                )

                tempMarkers.append(marker)
            }

            if let polylineEnd = polyline.coordinates.last {
                let marker = TripPoint(
                    id: UUID().uuidString,
                    source: .custom,
                    sourceId: nil,
                    name: "Arrivée de \(name)",
                    shortDescription: "",
                    coordinates: polylineEnd,
                    systemImage: "flag.checkered",
                    color: .label,
                    pointType: nil
                )

                tempMarkers.append(marker)
            }

            self.markers = tempMarkers
        }
    }

    let viewModel: ViewModel

    // -------------------------------------------------------------------------
    // MARK: - Body
    // -------------------------------------------------------------------------

    var body: some MapContent {
        TripMapPolyline(viewModel: viewModel.polyline)

        MarkersLayer(markers: .constant(viewModel.markers))
    }
}

#Preview {
    Map {
        CourseLayer(viewModel: .init(gpxUrl: .gr70Gpx))
    }
}
