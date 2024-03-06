//
//  MapView.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 06/02/2024.
//

import SwiftUI
import MapKit

struct RefugesMapView: View {

    /// Annotations to display on the map, representing refuges data
    @Binding var mapMarkers: [TripMapMarker]

    /// The camera position on the map
    @Binding var mapCameraPosition: MapCameraPosition

    /// Selected refuge annotation on the map
    @Binding var selectedRefugeId: RefugeId?

    // -------------------------------------------------------------------------
    // MARK: - Body
    // -------------------------------------------------------------------------

    var body: some View {
        Map(position: $mapCameraPosition, selection: $selectedRefugeId) {
            RefugesMapView.build(mapMarkers: mapMarkers)
        }
    }

    // -------------------------------------------------------------------------
    // MARK: - Related View Builders
    // -------------------------------------------------------------------------

    @MapContentBuilder
    static func build(mapMarkers: [TripMapMarker]) -> some MapContent {
        ForEach(mapMarkers, id: \.self) { marker in
            build(TripMapMarker: marker)
        }
    }

    @MapContentBuilder
    static func build(TripMapMarker: TripMapMarker) -> some MapContent {
        switch TripMapMarker {
        case .mkMapItem(let mKMapItem):
            Marker(item: mKMapItem)
        case .marker(let model):
            Marker(
                model.name,
                systemImage: model.systemImage,
                coordinate: model.coordinates
            )
        }
    }
}

#Preview {
    RefugesMapView(
        mapMarkers: .constant([
            .marker(.init(
                id: 0,
                name: "Cabane de Clartan",
                coordinates: .cabaneClartan,
                systemImage: "bed.double"
            )),
            .marker(.init(
                id: 1,
                name: "Gite de la Colle St Michel",
                coordinates: .giteDeLaColleStMichel,
                systemImage: "bed.double"
            ))
        ]),
        mapCameraPosition: .constant(
            .region(.init(
                center: .france,
                span: .init(latitudeDelta: 15.0, longitudeDelta: 15.0)
            ))
        ),
        selectedRefugeId: .constant(nil)
    )
}
