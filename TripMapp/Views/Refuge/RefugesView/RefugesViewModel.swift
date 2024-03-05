//
//  RefugesViewModel.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 29/08/2023.
//

import Foundation
import SwiftUI
import MapKit

class RefugesViewModel: ObservableObject {
    // MARK: Private properties

    private let router: AppRouter
    private let dataProvider: RefugesInfoDataProviderProtocol

    // MARK: - UI Properties

    @Published var mapCameraPosition: MapCameraPosition = .automatic

    @Published var mapItemsResults: [MKMapItem] = []
    @Published var selectedResult: MKMapItem?

    @Published var refugeType: RefugePointType?

    private var defaultRegion: MKCoordinateRegion = .france
    var visibleRegion: MKCoordinateRegion?

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
    func searchMapItems(query: String, filter: MKPointOfInterestFilter) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        request.resultTypes = .pointOfInterest
        request.pointOfInterestFilter = filter
        request.region = visibleRegion ?? defaultRegion

        Task {
            let search = MKLocalSearch(request: request)
            let response = try? await search.start()

            self.mapItemsResults = response?.mapItems ?? []
        }
    }

    private func loadRefugesAnnotations() async throws -> [MapAnnotationModel] {
        let refuges = try await dataProvider.loadRefuges(
            type: refugeType?.toRefugesInfoPointType,
            bbox: .init(mapCameraPosition: mapCameraPosition)
        )

        let annotations = refuges.features.map {
            MapAnnotationModel.init(refuge: $0)
        }

        return annotations
    }

    private func loadMassifsPolygons() async throws -> [MapPolygonModel] {
        let bbox = RefugesInfo.Bbox(mapCameraPosition: mapCameraPosition)

        let massifs = try await dataProvider.loadMassifs(
            type: .zone,
            massif: nil,
            bbox: bbox
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
