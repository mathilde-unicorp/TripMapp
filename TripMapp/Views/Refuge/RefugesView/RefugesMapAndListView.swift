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

    var body: some View {
        VStack {
            mapView()
            refugesList()
        }
    }

    @ViewBuilder func mapView() -> some View {
        RefugesMapView(
            annotations: viewModel.refugesMapAnnotations,
            mapCameraPosition: .constant(.region(.init(
                center: viewModel.mapCentralPoint,
                span: .init(latitudeDelta: 1.0, longitudeDelta: 1.0)
            )))
        )
        .frame(height: 400)
    }

    @ViewBuilder func refugesList() -> some View {
        List(viewModel.filteredRefuges, id: \.properties.id) { refuge in
            NavigationLink(destination: {
                viewModel.createRefugeDetailView(refugeId: refuge.properties.id)
            }, label: {
                RefugeCell(
                    name: refuge.properties.name,
                    image: refuge.properties.type.icon
                )
            })
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
                refuges: MockRefugesInfoDataProvider().refuges.map(\.toLightPoint)
            )
        }
    }
}
