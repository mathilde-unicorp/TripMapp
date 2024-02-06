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
            ZStack(alignment: .topLeading) {
                RefugeDescriptionView.Map(viewModel: viewModel)
                    .frame(height: 300)

                RefugeDescriptionView.Title(viewModel: viewModel)
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground.withAlphaComponent(0.5)))
            }

            TabView {
                // Access Information
                ScrollView {
                    AccessTabView(coordinate: viewModel.coordinate, access: viewModel.accessDescription)
                }
                .tabItem {
                    Image(systemName: "location.circle")
                    Text("Access")
                }

                // Place Information
                ScrollView {
                    InformationTabView(description: viewModel.description)
                }
                .tabItem {
                    Image(systemName: "info.circle")
                    Text("Information")
                }
            }
        }
    }
}

#Preview {
    RefugeDescriptionView(viewModel: .mock())
}
