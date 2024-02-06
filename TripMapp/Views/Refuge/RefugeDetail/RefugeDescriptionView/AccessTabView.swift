//
//  AccessTabView.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 25/08/2023.
//

import SwiftUI
import CoreLocation

extension RefugeDescriptionView {

    struct AccessTabView: View {
        let coordinate: CLLocationCoordinate2D
        let access: String

        var body: some View {
            VStack(alignment: .leading) {
                Text("Access Information")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding()

                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Image(systemName: "location.circle.fill")
                            .foregroundColor(.blue)
                        Text("Coordinates:")
                            .font(.headline)
                        Spacer()
                    }
                    Text("Latitude: \(coordinate.latitude)")
                    Text("Longitude: \(coordinate.longitude)")
                }
                .padding()

                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Image(systemName: "lock.circle.fill")
                            .foregroundColor(.green)
                        Text("Access:")
                            .font(.headline)
                        Spacer()
                    }
                    Text(access)
                }
                .padding()

                Spacer()
            }
        }
    }
}

struct AccessTabView_Previews: PreviewProvider {
    static let viewModel = RefugeDescriptionViewModel.mock()

    static var previews: some View {
        RefugeDescriptionView.AccessTabView(
            coordinate: viewModel.coordinate, access: viewModel.description
        )
    }
}
