//
//  MapView.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 04/05/2023.
//

import SwiftUI
import MapKit

struct MapView: View {

    let coordinate: CLLocationCoordinate2D
    let span: CGFloat
    let annotationItems: [AnnotationItem]

    @State private var region = MKCoordinateRegion()

    var body: some View {
        Map(coordinateRegion: $region, annotationItems: annotationItems) { item in
            // This produce a "[SwiftUI] Publishing changes from within view updates is not allowed, this will cause undefined behavior." error. But the fix is so ugly... :(
            MapAnnotation(coordinate: item.coordinate) {
                MapAnnotationItem(item: item)
            }
        }
        .onAppear {
            setRegion(coordinate)
        }
    }

    private func setRegion(_ coordinate: CLLocationCoordinate2D) {
        print("init with coordinates: \(coordinate)")
        region = MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span)
        )
    }
}

struct MapView_Previews: PreviewProvider {
    static let coordinate = CLLocationCoordinate2D(latitude: 34.011_286, longitude: -116.166_868)

    static var previews: some View {
        MapView(
            coordinate: coordinate,
            span: 0.02,
            annotationItems: [.init(
                coordinate: coordinate,
                title: "Title",
                image: Image(systemName: "tent")
            )]
        )
    }
}
