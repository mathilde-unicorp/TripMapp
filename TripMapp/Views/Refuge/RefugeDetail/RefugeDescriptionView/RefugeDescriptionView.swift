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
            MapView(
                coordinate: viewModel.coordinate,
                span: 0.02,
                annotationItems: [
                    .init(
                        coordinate: viewModel.coordinate,
                        title: viewModel.title,
                        image: viewModel.icon
                    )
                ]
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
