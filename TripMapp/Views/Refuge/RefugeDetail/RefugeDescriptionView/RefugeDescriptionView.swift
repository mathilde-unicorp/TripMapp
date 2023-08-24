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
            ZStack(alignment: .bottomLeading) {
                MapView(coordinate: viewModel.coordinate)
                    .frame(height: 400)

                RefugeTitleView(
                    icon: viewModel.icon,
                    title: viewModel.title,
                    placeID: viewModel.placeID
                )
                .padding()
                .background(Color(uiColor: .systemBackground).opacity(0.8))
            }

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
