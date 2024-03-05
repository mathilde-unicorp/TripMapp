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

    var body: some View {
        NavigationView {
            Map(
                position: $viewModel.mapCameraPosition,
                selection: $viewModel.selectedResult
            ) {
                UserAnnotation()

                Marker("Gite", systemImage: "house", coordinate: .giteDeLaColleStMichel)
                    .tint(.green)

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
                    if let selectedResult = viewModel.selectedResult {
                        MapItemInfoView(selectedItem: selectedResult)
                            .frame(height: 128)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .padding([.top, .horizontal])
                    }

                    PointsOfInterestsButtons(
                        onSelect: { category in
                            viewModel.searchMapItems(
                                query: category.defaultQuery,
                                filter: category.mkPointOfInterestFilter
                            )
                        }
                    )
                    .setFullWidth(alignment: .center)
                    .padding(.top)
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
