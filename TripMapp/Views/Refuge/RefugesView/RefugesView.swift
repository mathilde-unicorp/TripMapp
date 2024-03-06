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

    @State private var selectedResult: MKMapItem?
    @State private var mapCameraPosition: MapCameraPosition = .automatic

    var body: some View {
        NavigationView {
            Map(
                position: $mapCameraPosition,
                selection: $selectedResult
            ) {
                UserAnnotation()

                ForEach(viewModel.mapItemsResults, id: \.self) { result in
                    Marker(item: result)
                }
            }
            .mapStyle(.imagery(elevation: .realistic))
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
                        MapItemInfoView(selectedItem: selectedResult)
                            .frame(height: 128)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .padding([.top, .horizontal])
                    }

                    VStack(spacing: 12.0) {
                        PointsOfInterestsButtons(
                            title: "Services",
                            categories: ServicesPointsOfInterests.allCases,
                            onSelect: { category in
                                viewModel.searchMapItems(serviceType: category)
                            }
                        )

                        PointsOfInterestsButtons(
                            title: "Accomodations",
                            categories: AccomodationsPointsOfInterests.allCases,
                            onSelect: { accomodationType in
                                viewModel.searchMapItems(accomodationType: accomodationType)
                            })
                    }
                    .padding()
                }
                .background(.thinMaterial)
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
            AppRouter.shared.createRefugesView(refugeType: nil)
        }
    }
}


//                AsyncMapView(
//                    source: viewModel,
//                    loadingView: MapProgressView()
//                ) { content in
//                    RefugesMapView.buildMapContent(
//                        annotations: Array(content.annotations)
//                    )
//
//                    // Do not display massifs yet, it's not ready
//                    // MassifsMapView.buildMapContent(
//                    //    massifs: Array(content.polygons)
//                    // )
//                }
//                .sheet(item: $viewModel.selectedItem) { item in
//                    viewModel.createRefugeDetailView(refugeId: item)
//                }
