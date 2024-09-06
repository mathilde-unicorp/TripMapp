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

    // -------------------------------------------------------------------------
    // MARK: - Parameters
    // -------------------------------------------------------------------------

    /// Displayed region on the map
    @Binding var visibleRegion: MKCoordinateRegion?

    /// Currently selected item on the map, by id
    @Binding var selectedItemId: String?

    /// Map content builder
    @MapContentBuilder var mapContentBuilder: () -> TripMapContentView

    // -------------------------------------------------------------------------
    // MARK: - Private properties
    // -------------------------------------------------------------------------

    @ObservedObject private var locationManager: CLLocationManagerObject = .init()

    @State private var mapCameraPosition: MapCameraPosition = .automatic

    private var userLocationVisibility: Visibility {
        locationManager.locationAuthorization.isAuthorized ? .visible : .hidden
    }

    // -------------------------------------------------------------------------
    // MARK: - Body
    // -------------------------------------------------------------------------

    var body: some View {
        Map(
            position: $mapCameraPosition,
            selection: $selectedItemId
        ) {
            mapContentBuilder()
        }
        .mapStyle(.hybrid(elevation: .realistic))
        .mapControls {
                MapUserLocationButton()
                    .mapControlVisibility(userLocationVisibility)
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

// =============================================================================
// MARK: - Preview
// =============================================================================

struct TripMap_Previews: PreviewProvider {

    struct ContainerView: View {
        @State private var visibleRegion: MKCoordinateRegion?
        @State private var selectedItem: String?

        var body: some View {
            TripMap(
                visibleRegion: $visibleRegion,
                selectedItemId: $selectedItem
            ) {
                MarkersLayer(markers: .constant(TripPoint.mocks))

                PolylinesLayer(
                    polylines: .constant(TripMapPolyline.ViewModel.mocks)
                )
            }
        }
    }

    static var previews: some View {
        ContainerView()
    }
}
