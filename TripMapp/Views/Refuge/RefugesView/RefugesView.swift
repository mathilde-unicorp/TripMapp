//
//  RefugeList.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 22/08/2023.
//

import SwiftUI
import MapKit

struct RefugesView: View {
    @ObservedObject var viewModel: RefugesViewModel
    @ObservedObject var locationManager: CLLocationManagerObject = .init()

    @State private var selectedResult: TripMapMarker?
    @State private var mapCameraPosition: MapCameraPosition = .automatic

    @State private var selectedPOITypes: Set<PointsOfInterestType> = .init()

    var body: some View {
        NavigationStack {
            Map(
                position: $mapCameraPosition,
                selection: $selectedResult
            ) {
                UserAnnotation()

                RefugesMapView.build(
                    mapMarkers: viewModel.mapItemsResults
                )
            }
            .mapStyle(.hybrid(elevation: .realistic))
            .mapControls {
                if locationManager.locationAuthorization.isAuthorized {
                    MapUserLocationButton()
                }
                MapCompass()
                MapScaleView()
            }
            .safeAreaInset(edge: .bottom) {
                VStack {
                    if let selectedResult = selectedResult {
                        TripMapMarkerInfoView(mapItem: selectedResult)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .padding([.top, .horizontal])
                    }

                    PointsOfInterestMapFilterView(selectedTypes: $selectedPOITypes)
                }
                .background(.thinMaterial)
            }
            .onChange(of: selectedPOITypes) { _, selectedTypes in
                self.viewModel.searchMapItems(of: selectedTypes)
            }
            .onChange(of: viewModel.mapItemsResults) {
                // refocus the map automatically on results
                // position = .automatic
            }
            .onMapCameraChange { context in
                self.viewModel.visibleRegion = context.region
            }
        }
    }
}

struct RefugesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AppRouter.shared.createRefugesView()
                .environmentObject(AppRouter.shared) // not the best options for now
        }
    }
}
