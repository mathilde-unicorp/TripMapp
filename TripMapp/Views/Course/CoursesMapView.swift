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

    let courses: [GPXCoursePolyline.ViewModel]

    @State private var selectedPolyline: Int?

    init(gpxURLs: [URL]) {
        self.courses = gpxURLs.enumerated().compactMap { index, url in
            GPXCoursePolyline.ViewModel(id: index, gpxURL: url)
        }
    }

    var body: some View {
        Map(selection: $selectedPolyline) {
            ForEach(courses, id: \.id) {
                GPXCoursePolyline(viewModel: $0)
            }
        }
        .onChange(of: selectedPolyline) { _, polyline in
            print(polyline ?? -1)
        }
    }
}

#Preview {
    CoursesMapView(gpxURLs: [.gr66Gpx, .gr70Gpx])
}
