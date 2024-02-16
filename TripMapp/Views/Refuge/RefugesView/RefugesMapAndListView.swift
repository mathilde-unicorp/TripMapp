//
//  RefugesView+refugesList.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 22/08/2023.
//

import SwiftUI
import CoreLocation

struct RefugesMapAndListView: View {

    @ObservedObject var viewModel: RefugesMapAndListViewModel

    @State private var selectedRefugeId: RefugeId?

    var body: some View {
        VStack {
            mapView()
            refugesList()
        }
        .sheet(item: $selectedRefugeId) { refugeId in
            viewModel.createRefugeDetailView(refugeId: refugeId)
        }
    }

    @ViewBuilder func mapView() -> some View {
        RefugesMapView(
            annotations: $viewModel.refugesMapAnnotations,
            mapCameraPosition: $viewModel.mapCameraPosition,
            selectedRefugeId: $selectedRefugeId
        )
        .frame(height: 300)
    }

    @ViewBuilder func refugesList() -> some View {
        List(viewModel.filteredRefuges, id: \.properties.id) { refuge in
            Button(
                action: { self.selectedRefugeId = refuge.properties.id },
                label: {
                    RefugeCell(
                        name: refuge.properties.name,
                        image: refuge.properties.type.icon
                    )
                }
            )
            .id(refuge.properties.id)
        }
        .listStyle(.plain)
        .searchable(text: $viewModel.searchText)
        .overlay {
            if viewModel.filteredRefuges.isEmpty {
                Text("Sorry, no result found.")
                    .font(.headline)
            }
        }
    }
}

struct RefugesView_refugesList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AppRouter.shared.createRefugesMapAndListView(
                refuges: MockRefuges.refuges.map(\.toLightPoint)
            )
        }
    }
}
