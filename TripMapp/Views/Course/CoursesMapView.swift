//
//  TripCourseView.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 03/04/2024.
//

import SwiftUI
import MapKit
import Unicorp_GPXFile

struct CoursesMapView: View {

    let courses: [MapPolylineModel]

    @State private var selectedPolyline: Int?

//
//    init(gpxURL: URL) {
//        self.init(gpxURLs: [gpxURL])
//    }
//
    init(gpxURLs: [URL]) {
        self.courses = gpxURLs.enumerated().compactMap { index, url in
            let parser = GPXParser()

            guard let content = try? parser.parse(gpxFileURL: url) else {
                return nil
            }

            let coordinates = content.trackpoints.map { $0.coordinates }
            return MapPolylineModel(id: index, name: content.name ?? "--", coordinates: coordinates, color: .blue)
        }
    }

    var body: some View {
        Map(selection: $selectedPolyline) {
            TripMapView.build(polylines: courses)
        }
        .onChange(of: selectedPolyline) { _, polyline in
            print(polyline)
        }
    }
}

#Preview {
    CoursesMapView(gpxURLs: [.gr66Gpx, .gr70Gpx])
}
