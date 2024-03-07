//
//  MapItemInfoView.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 05/03/2024.
//

import SwiftUI
import MapKit

struct TripMapMarkerInfoView: View {

    var mapItem: TripMapMarker

    var body: some View {
        switch mapItem {
        case .mkMapItem(let mapItem):
            MKMapMarkerInfoView(mapItem: mapItem)
        case .marker(let marker):
            MapMarkerInfoView(mapItem: marker)
        }
    }
}

#Preview {
    VStack {
        TripMapMarkerInfoView(
            mapItem: .mkMapItem(.init(
                placemark: .init(coordinate: .giteDeLaColleStMichel))
            )
        )

        Divider()

        TripMapMarkerInfoView(
            mapItem: .marker(.init(
                id: 0,
                name: "Gite de la Colle St Michel",
                coordinates: .giteDeLaColleStMichel,
                systemImage: "tent"))
        )
    }
    .environmentObject(AppRouter.mock)
}
