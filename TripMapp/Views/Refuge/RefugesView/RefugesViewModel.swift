//
//  RefugesViewModel.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 29/08/2023.
//

import Foundation
import SwiftUI
import MapKit

class RefugesViewModel: ObservableObject, LoadableMapObject {
    // MARK: Private properties

    private let router: AppRouter
    private let dataProvider: RefugesInfoDataProviderProtocol

    // MARK: - UI Properties

    @Published var state: LoadingState<MapContentModel> = .idle
    @Published var mapCameraPosition: MapCameraPosition = .region(
        .init(center: .france,
              span: .init(latitudeDelta: 2.0, longitudeDelta: 2.0))
    )
    @Published var visibleMapRegion: MKCoordinateRegion?

    @Published var selectedItem: Int?
    @Published var refugeType: RefugePointType?

    private var savedContent = MapContentModel(annotations: [], polygons: [])

    // MARK: - Init

    init(
        refugeType: RefugePointType?,
        dataProvider: RefugesInfoDataProviderProtocol,
        router: AppRouter
    ) {
        self.refugeType = refugeType
        self.dataProvider = dataProvider
        self.router = router
    }

    // MARK: - Requests

    @MainActor
    func load() {
        self.state = .loading

        Task { [weak self] in
            guard let self = self else { return }

            do {
                let refugesAnnotations = try await loadRefugesAnnotations()
                let massifsPolygons = try await loadMassifsPolygons()

                self.savedContent.insert(annotations: refugesAnnotations)
                self.savedContent.insert(polygons: massifsPolygons)

                self.state = .loaded(self.savedContent)
            } catch {
                self.state = .failed(error)
            }
        }
    }

    private func loadRefugesAnnotations() async throws -> [MapAnnotationModel] {
        guard let region = visibleMapRegion ?? mapCameraPosition.region else {
            return []
        }

        let refuges = try await dataProvider.loadRefuges(
            type: refugeType?.toRefugesInfoPointType,
            bbox: .init(region: region)
        )

        let annotations = refuges.features.map {
            MapAnnotationModel.init(refuge: $0)
        }

        return annotations
    }

    private func loadMassifsPolygons() async throws -> [MapPolygonModel] {
        guard let region = visibleMapRegion ?? mapCameraPosition.region else {
            return []
        }

        let massifs = try await dataProvider.loadMassifs(
            type: .zone,
            massif: nil,
            bbox: .init(region: region)
        )

        let polygons = massifs.features.map {
            MapPolygonModel(massif: $0)
        }

        return polygons
    }

    // -------------------------------------------------------------------------
    // MARK: - Router
    // -------------------------------------------------------------------------

    func createRefugeDetailView(refugeId: Int) -> RefugeDetailView {
        router.createRefugeDetailView(refugeId: refugeId)
    }
}
