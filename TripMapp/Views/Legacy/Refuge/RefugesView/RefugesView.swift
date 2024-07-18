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

    @State private var selectedResult: String?
    @State private var selectedTripPointTypes: [TripPointType] = []

    var body: some View {
        EmptyView()
//        SearchableTripMap(
//            searchOnRegion: $viewModel.visibleRegion,
//            selectedItem: $selectedResult,
//            onRefreshResult: {
//                self.searchMapItems(for: .init(selectedTripPointTypes))
//            }, mapContent: {
//                TripMapContent(
//                    markers: $viewModel.markers,
//                    polylines: .constant([])
//                )
//            }
//        )
//        .safeAreaInset(edge: .bottom) {
//            VStack {
//                selectedResultOverview()
//                    .padding()
//
//                if selectedResult == nil {
//                    MapSearchBar(selectedTripPointTypes: $selectedTripPointTypes)
//                }
//            }
//            .background(.thinMaterial)
//        }
//        .onChange(of: selectedTripPointTypes) { _, selectedTypes in
//            self.searchMapItems(for: .init(selectedTypes))
//
//        }
    }

    @ViewBuilder
    private func selectedResultOverview() -> some View {
        if let selectedResult = selectedResult,
            let marker = viewModel.markers.first(where: { $0.id == selectedResult}) {
            TripPointInfoView(selectedMarker: .constant(marker))
        }
    }

    @ViewBuilder
    private func filtersView() -> some View {
        PointsOfInterestMapFilterView(selectedTypes: $selectedTripPointTypes)
    }

    private func searchMapItems(for types: Set<TripPointType>) {
        self.viewModel.searchMapItems(of: .init(selectedTripPointTypes))
    }
}

struct RefugesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AppRouter.mock.createRefugesView()
        }
        .environmentObject(AppRouter.mock) // not the best options for now
        .configureEnvironmentForPreview()
    }
}
