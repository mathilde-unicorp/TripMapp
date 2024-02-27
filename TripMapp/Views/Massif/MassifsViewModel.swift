//
//  MassifsViewModel.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 10/02/2024.
//

import Foundation
import SwiftUI
import MapKit

class MassifsViewModel: ObservableObject, LoadableObject {

    // MARK: - UI Properties

    @Published var state: LoadingState<[MapPolygonModel]> = .idle
    @Published var selectedMassif: Int?

    @Published var mapCameraPosition: MapCameraPosition = .region(
        .init(center: .france,
              span: .init(latitudeDelta: 10.0, longitudeDelta: 10.0))
    )

    // MARK: Private properties

    private let router: AppRouter
    private let dataProvider: RefugesInfoDataProviderProtocol

    // MARK: - Init

    init(
        dataProvider: RefugesInfoDataProviderProtocol,
        router: AppRouter
    ) {
        self.dataProvider = dataProvider
        self.router = router
    }

    // MARK: - Requests

    @MainActor
    func load() {
        guard let region = mapCameraPosition.region else { return }

        self.state = .loading

        Task { [weak self] in
            guard let self = self else { return }

            do {
                let massifs = try await dataProvider.loadMassifs(
                    type: .zone,
                    massif: nil,
                    bbox: .init(region: region)
                )

                let polygons = massifs.features.map {
                    MapPolygonModel(massif: $0)
                }

                self.state = .loaded(polygons)
            } catch {
                self.state = .failed(error)
            }
        }
    }

    // MARK: - Router

    @ViewBuilder
    func createRefugesMapView(for massif: String) -> some View {
        Text("Massif \(massif)")
    }
}
