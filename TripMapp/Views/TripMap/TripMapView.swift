//
//  TripMapView.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 06/02/2024.
//

import SwiftUI
import MapKit

struct TripMapView: View {

    /// Annotations to display on the map, representing refuges data
    @Binding var mapMarkers: [TripMapMarker]

    /// The camera position on the map
    @Binding var mapCameraPosition: MapCameraPosition

    /// Selected refuge annotation on the map
    @Binding var selectedResult: TripMapMarker?

    var scope: Namespace.ID?

    // -------------------------------------------------------------------------
    // MARK: - Body
    // -------------------------------------------------------------------------

    var body: some View {
        Map(
            position: $mapCameraPosition,
            selection: $selectedResult,
            scope: scope
        ) {
            TripMapView.build(mapMarkers: mapMarkers)
        }
        .mapStyle(.hybrid(elevation: .realistic))
    }
}

#Preview {
    TripMapView(
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
        selectedResult: .constant(nil)
    )
}
