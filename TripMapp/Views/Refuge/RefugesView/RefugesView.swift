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

    @State private var mapPositionHasChanged: Bool = false
    @State private var selectedResult: UUID?
    @State private var mapCameraPosition: MapCameraPosition = .automatic

    @State private var selectedPOITypes: Set<PointsOfInterestType> = .init()

    @Namespace private var refugesMap

    private var mapUserLocationVisibility: Visibility {
        if locationManager.locationAuthorization.isAuthorized {
            return .visible
        } else {
            return .hidden
        }
    }

    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                Map(
                    position: $mapCameraPosition,
                    selection: $selectedResult,
                    scope: refugesMap
                ) {
                    SearchPointsOfInterestsLayer(
                        refugesInfoResults: $viewModel.refugesInfoResults,
                        mkMapItemsResults: $viewModel.mkMapItemsResults
                    )
                }
                .mapStyle(.hybrid(elevation: .realistic))
                .mapControls {
                    MapUserLocationButton()
                        .mapControlVisibility(mapUserLocationVisibility)
                    MapCompass()
                    MapScaleView()
                }
                .safeAreaInset(edge: .bottom) {
                    VStack(spacing: 16.0) {
                        selectedResultOverview()
                        filtersView()
                    }
                    .padding()
                    .background(.thinMaterial)
                }

                refreshButton()
            }
            .onChange(of: selectedPOITypes) { _, selectedTypes in
                self.searchMapItems(for: selectedTypes)
            }
//            .onChange(of: viewModel.mapItemsResults) {
//                // refocus the map automatically on results
//                // position = .automatic
//            }
            .onMapCameraChange { context in
                let newRegion = context.region
                if let visibleRegion = self.viewModel.visibleRegion,
                   visibleRegion.toBbox != newRegion.toBbox {
                    // do not notify the first setup or if the region do not changes
                    withAnimation { self.mapPositionHasChanged = true }
                }
                self.viewModel.visibleRegion = context.region
            }
        }
    }

    @ViewBuilder
    private func refreshButton() -> some View {
        if mapPositionHasChanged {
            Button(action: {
                self.searchMapItems(for: selectedPOITypes)
            }, label: {
                Label("refresh_here", systemImage: "arrow.clockwise")
            })
            .buttonStyle(.bordered)
            .background(.thinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 8.0))
            .padding(10.0)
        }
    }

    @ViewBuilder
    private func selectedResultOverview() -> some View {
        if let selectedResult = selectedResult {
            if let refugesInfoMarker = viewModel.refugesInfoResults.first(
                where: { $0.id == selectedResult }
            ) {
                MapMarkerInfoView(mapItem: refugesInfoMarker)
            } else if let mkMapItemMarker = viewModel.mkMapItemsResults.first(
                where: { $0.id == selectedResult }
            ) {
                MKMapMarkerInfoView(mapItem: mkMapItemMarker.mkMapItem)
            }
        }
    }

    @ViewBuilder
    private func filtersView() -> some View {
        PointsOfInterestMapFilterView(selectedTypes: $selectedPOITypes)
    }

    private func searchMapItems(for types: Set<PointsOfInterestType>) {
        self.viewModel.searchMapItems(of: selectedPOITypes)

        withAnimation {
            self.mapPositionHasChanged = false
        }
    }
}

struct RefugesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AppRouter.mock.createRefugesView()
                .environmentObject(AppRouter.mock) // not the best options for now
        }
    }
}
