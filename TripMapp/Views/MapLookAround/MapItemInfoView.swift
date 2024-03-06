//
//  MapItemInfoView.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 05/03/2024.
//

import SwiftUI
import MapKit

struct MapItemInfoView: View {
    var mapItem: TripMapMarker

    @State private var lookAroundScene: MKLookAroundScene?
    @State private var openDetailedResult: TripMapMarker?

    @EnvironmentObject private var router: AppRouter

    var body: some View {
        switch mapItem {
        case .mkMapItem(let mapItem):
            mkMapItemInfoView(item: mapItem)
        case .marker(let annotation):
            mapMarkerInfoView(item: annotation)
        }
    }

    @ViewBuilder
    private func mapMarkerInfoView(item: MapMarkerModel) -> some View {
        VStack(alignment: .leading) {
            Label(item.name, systemImage: item.systemImage)
                .font(.headline)

            Button(action: {
                openDetailedResult = mapItem
            }, label: {
                Text("Open details")
            })
        }
        .frame(height: 38)
        .sheet(item: $openDetailedResult) { item in
            switch item {
            case .marker(let model):
                router.createRefugeDetailView(refugeId: model.id)
            default:
                EmptyView()
            }
        }
    }

    @ViewBuilder
    private func mkMapItemInfoView(item: MKMapItem) -> some View {
        LookAroundPreview(initialScene: lookAroundScene)
            .frame(height: 128)
            .overlay(alignment: .bottomTrailing) {
                HStack {
                    Text(item.name ?? "")
                }
                .font(.caption)
                .foregroundStyle(.white)
                .padding(10)
            }
            .onAppear {
                getLookAroundScene()
            }
            .onChange(of: item) {
                getLookAroundScene()
            }

    }
    // MARK: - Tools

    func getLookAroundScene() {
        lookAroundScene = nil

        guard case .mkMapItem(let mapItem) = mapItem else { return }

        Task {
            let request = MKLookAroundSceneRequest(mapItem: mapItem)
            lookAroundScene = try await request.scene
        }
    }
}

#Preview {
    VStack {
        MapItemInfoView(
            mapItem: .mkMapItem(.init(
                placemark: .init(coordinate: .giteDeLaColleStMichel))
            )
        )

        Divider()

        MapItemInfoView(
            mapItem: .marker(.init(
                id: 0,
                name: "Gite de la Colle St Michel",
                coordinates: .giteDeLaColleStMichel,
                systemImage: "tent"))
        )
    }
    .environmentObject(AppRouter.mock)
}
