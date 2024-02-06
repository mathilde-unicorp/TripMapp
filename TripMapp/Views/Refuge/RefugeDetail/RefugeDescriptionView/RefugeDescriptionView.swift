//
//  RefugeDescriptionView.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 24/08/2023.
//

import SwiftUI
import CoreLocation

struct RefugeDescriptionView: View {

    let viewModel: RefugeDescriptionViewModel

    var body: some View {
        VStack {
            RefugesMapView(
                annotations: .constant([
                    .init(
                        id: viewModel.placeID,
                        name: viewModel.title,
                        coordinates: viewModel.coordinate,
                        image: viewModel.icon
                    )
                ]),
                mapCameraPosition: .constant(.region(.init(
                    center: viewModel.coordinate,
                    span: .init(latitudeDelta: 0.02, longitudeDelta: 0.02)
                ))),
                selectedRefugeId: .constant(nil)
            )
            .frame(height: 300)

            RefugeTitleView(
                icon: viewModel.icon,
                title: viewModel.title,
                placeID: viewModel.placeID
            )
            .padding()

            TabView {

                // First Tab: Place Information
                ScrollView {
                    InformationTabView(description: viewModel.description)
                }
                .tabItem {
                    Image(systemName: "info.circle")
                    Text("Information")
                }

                // Second Tab: Access Information
                ScrollView {
                    AccessTabView(coordinate: viewModel.coordinate, access: viewModel.access)
                }
                .tabItem {
                    Image(systemName: "location.circle")
                    Text("Access")
                }
            }
        }
        .ignoresSafeArea()
    }
}

struct RefugeDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        RefugeDescriptionView(viewModel: .mock())
    }
}
