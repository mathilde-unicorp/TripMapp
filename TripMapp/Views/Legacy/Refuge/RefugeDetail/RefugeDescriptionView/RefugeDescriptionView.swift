//
//  RefugeDescriptionView.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 24/08/2023.
//

import SwiftUI
import CoreLocation

struct RefugeDescriptionView: View {

    let viewModel: ViewModel

    var body: some View {
        VStack {
            RefugeDescriptionView.AccessMap(marker: viewModel.marker)
                .frame(height: 300)
                .overlay(alignment: .top) {
                    RefugeDescriptionView.Title(viewModel: viewModel)
                        .padding()
                        .background(Color.secondarySystemBackground.opacity(0.5))
                }

            TabView {
                // Global Informations
                ScrollView {
                    InformationsTabView(viewModel: viewModel)
                }
                .tabItem {
                    Image(systemName: "info.circle")
                    Text("informations_title")
                }

                // Access Information
                ScrollView {
                    AccessTabView(viewModel: viewModel)
                }
                .tabItem {
                    Image(systemName: "location.circle")
                    Text("access_title")
                }

            }
        }
    }
}

#Preview {
    RefugeDescriptionView(viewModel: .mock())
}
