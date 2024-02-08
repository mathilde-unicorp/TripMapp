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
            ZStack(alignment: .topLeading) {
                RefugeDescriptionView.Map(viewModel: viewModel)
                    .frame(height: 300)

                RefugeDescriptionView.Title(viewModel: viewModel)
                    .padding()
                    .background(Color.secondarySystemBackground.opacity(0.5))
            }

            TabView {
                // Access Information
                ScrollView {
                    AccessTabView(viewModel: viewModel)
                }
                .tabItem {
                    Image(systemName: "location.circle")
                    Text("Access")
                }

                // Place Information
                ScrollView {
                    InformationsTabView(viewModel: viewModel)
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
