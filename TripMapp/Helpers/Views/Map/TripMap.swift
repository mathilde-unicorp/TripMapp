//
//  TripMap.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 01/07/2024.
//

import SwiftUI
import MapKit

/// A Map configured for the current usages of the application
struct TripMap<TripMapContentView: MapContent>: View {

    @Binding var visibleRegion: MKCoordinateRegion?
    @Binding var selectedItem: String?

    @MapContentBuilder var mapContentBuilder: () -> TripMapContentView

    // -------------------------------------------------------------------------
    // MARK: - Private properties
    // -------------------------------------------------------------------------

    @ObservedObject private var locationManager: CLLocationManagerObject = .init()

    @State private var mapCameraPosition: MapCameraPosition = .automatic

    private var mapUserLocationVisibility: Visibility {
        if locationManager.locationAuthorization.isAuthorized {
            return .visible
        } else {
            return .hidden
        }
    }

    // -------------------------------------------------------------------------
    // MARK: - Body
    // -------------------------------------------------------------------------

    var body: some View {
        Map(
            position: $mapCameraPosition,
            selection: $selectedItem
        ) {
            mapContentBuilder()
        }
        .mapStyle(.hybrid(elevation: .realistic))
        .mapControls {
                MapUserLocationButton()
                    .mapControlVisibility(mapUserLocationVisibility)
                MapCompass()
                MapScaleView()
            }
        .onMapCameraChange { context in
            let newRegion = context.region

            if self.visibleRegion != newRegion {
                self.visibleRegion = newRegion
            }
        }
    }
}

struct TripMap_Previews: PreviewProvider {

    struct ContainerView: View {
        @State private var visibleRegion: MKCoordinateRegion?
        @State private var selectedItem: String?

        var body: some View {
            TripMap(
                visibleRegion: $visibleRegion,
                selectedItem: $selectedItem
            ) {
                TripMapContent(
                    markers: .constant(TripMapMarker.ViewModel.mocks),
                    polylines: .constant(TripMapPolyline.ViewModel.mocks)
                )
            }
        }
    }

    static var previews: some View {
        ContainerView()
    }
}
