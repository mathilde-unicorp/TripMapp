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

    @State private var selectedResult: UUID?
    @State private var selectedPOITypes: [PointsOfInterestType] = []

    var body: some View {
        MapSearchView(
            visibleRegion: $viewModel.visibleRegion,
            markers: $viewModel.markers,
            polylines: .constant([]),
            selectedItem: $selectedResult,
            onRefreshResult: {
                self.searchMapItems(for: .init(selectedPOITypes))
            }
        )
        .safeAreaInset(edge: .bottom) {
            VStack {
                selectedResultOverview()
                    .padding()

                if selectedResult == nil {
                    MapSearchBar(selectedPOITypes: $selectedPOITypes)
                }
            }
            .background(.thinMaterial)
        }
        .onChange(of: selectedPOITypes) { _, selectedTypes in
            self.searchMapItems(for: .init(selectedTypes))
        }
    }

    @ViewBuilder
    private func selectedResultOverview() -> some View {
        if let selectedResult = selectedResult,
            let marker = viewModel.markers.first(where: { $0.id == selectedResult}) {
            switch marker.source {
            case .refugesInfo:
                MapMarkerInfoView(mapItem: marker)
            case .mkMap:
                MKMapMarkerInfoView(mapItem: marker)
            case .custom:
                EmptyView()
            }
        }
    }

    @ViewBuilder
    private func filtersView() -> some View {
        PointsOfInterestMapFilterView(selectedTypes: $selectedPOITypes)
    }

    private func searchMapItems(for types: Set<PointsOfInterestType>) {
        self.viewModel.searchMapItems(of: .init(selectedPOITypes))
    }
}

struct RefugesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AppRouter.mock.createRefugesView()
        }
        .environmentObject(AppRouter.mock) // not the best options for now
        .environment(\.managedObjectContext, .previewViewContext)
    }
}
