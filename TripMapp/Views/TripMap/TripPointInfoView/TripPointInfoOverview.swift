//
//  DefaultMapMarkerInfoView.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 07/03/2024.
//

import SwiftUI
import MapKit

struct TripPointInfoOverview: View {

    let tripPoint: TripPoint
    let currentProject: TripProjectEntity?

    @EnvironmentObject private var router: AppRouter

    @Environment(\.managedObjectContext) private var viewContext

    @State private var shouldOpenDetailedResult: Bool = false

    @State private var selectedProject: TripProjectEntity?

    // -------------------------------------------------------------------------
    // MARK: - Body
    // -------------------------------------------------------------------------

    var body: some View {
        VStack(alignment: .leading) {
            Label(tripPoint.name, systemImage: tripPoint.systemImage)
                .font(.headline)

            HStack {
                VStack(alignment: .leading) {
                    Text(tripPoint.shortDescription)
                        .lineLimit(3)
                        .font(.caption)
                        .foregroundStyle(.secondary)

                    HStack(spacing: 16.0) {
                        AddToProjectButton(mapItem: tripPoint)
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
            if case .refugesInfo(let refugeId) = tripPoint.source {
                router.createRefugeDetailView(refugeId: refugeId) // TODO: not using AppRouter
            }
        }
    }

}

#Preview {
    TripPointInfoOverview(
        tripPoint: .mocks.first!,
        currentProject: nil
    )
    .configureEnvironmentForPreview()
}
