//
//  DefaultMapMarkerInfoView.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 07/03/2024.
//

import SwiftUI
import MapKit

struct TripMapMarkerInfoOverview: View {

    var mapItem: TripMapMarker.ViewModel

    @EnvironmentObject private var router: AppRouter

    @State private var shouldOpenDetailedResult: Bool = false

    var body: some View {
        VStack(alignment: .leading) {
            Label(mapItem.name, systemImage: mapItem.systemImage)
                .font(.headline)

            HStack {
                VStack(alignment: .leading) {
                    Text(mapItem.shortDescription)
                        .lineLimit(3)
                        .font(.caption)
                        .foregroundStyle(.secondary)

                    HStack(spacing: 16.0) {
                        Button("add_to_project", systemImage: "plus") {
                            // do something
                        }
                        .buttonStyle(.borderedProminent)
                        .font(.caption)

                        Spacer()

                        Button("open_details_title", systemImage: "arrow.up.right.square") {
                            shouldOpenDetailedResult = true
                        }
                    }
                }

            }
        }
        .sheet(isPresented: $shouldOpenDetailedResult) {
            if case .refugesInfo(let refugeId) = mapItem.source {
                router.createRefugeDetailView(refugeId: refugeId) // TODO: not using AppRouter
            }
        }
    }
}

#Preview {
    TripMapMarkerInfoOverview(mapItem: .mocks.first!)
        .configureEnvironmentForPreview()
}
