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
        let altitude: Int
        let accessDescription: String

        init(coordinate: CLLocationCoordinate2D, altitude: Int, accessDescription: String) {
            self.coordinate = coordinate
            self.altitude = altitude
            self.accessDescription = accessDescription
        }

        init(viewModel: RefugeDescriptionViewModel) {
            self.coordinate = viewModel.coordinate
            self.altitude = viewModel.altitude
            self.accessDescription = viewModel.accessDescription
        }

        var body: some View {
            VStack(alignment: .leading, spacing: 32.0) {
                Text("Access Information")
                    .font(.title2)
                    .fontWeight(.bold)


                coordinatesSection()

                Divider()

                accessSection()


                Spacer()
            }
            .padding()
        }

        @ViewBuilder private func coordinatesSection() -> some View {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Image(systemName: "location.circle.fill")
                        .foregroundColor(.blue)

                    Text("Coordinates")
                    
                    Spacer()
                }
                .font(.headline)

                HStack {
                    Text("Lat.: \(coordinate.latitude)")
                    Text("Long.: \(coordinate.longitude)")
                }
                Text("Altitude: \(altitude)m")
            }
        }

        @ViewBuilder private func accessSection() -> some View {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Image(systemName: "lock.circle.fill")
                        .foregroundColor(.green)

                    Text("Access")

                    Spacer()
                }
                .font(.headline)

                Text(accessDescription)
                    .font(.body)
            }
        }
    }
}

struct AccessTabView_Previews: PreviewProvider {
    static var previews: some View {
        RefugeDescriptionView.AccessTabView(viewModel: .mock())
    }
}
