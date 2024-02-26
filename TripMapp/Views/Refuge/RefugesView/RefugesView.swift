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
    @ObservedObject var requestLocationViewModel: RequestLocationViewModel

    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                AsyncMapView(
                    source: viewModel,
                    loadingView: MapProgressView()
                ) { content in
                    // Create refuges map content
                    RefugesMapView.buildMapContent(
                        annotations: Array(content.annotations)
                    )

                    // Display user position
                    UserAnnotation()
                }
                .sheet(item: $viewModel.selectedItem) { item in
                    // Present refuge details when selected
                    viewModel.createRefugeDetailView(refugeId: item)
                }

                RequestLocationButton() {
                    requestLocationViewModel.requestLocation()
                }
                .onChange(of: requestLocationViewModel.location) { _, updatedLocation in
                    guard let location = updatedLocation else { return }

                    withAnimation {
                        viewModel.mapCameraPosition = .region(
                            .init(center: location, span: .init(latitudeDelta: 1.0, longitudeDelta: 1.0))
                        )

                        viewModel.load()
                    }
                }
            }
        }
    }
}

struct RefugesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AppRouter.shared.createRefugesView(refugeType: nil)
        }
    }
}
