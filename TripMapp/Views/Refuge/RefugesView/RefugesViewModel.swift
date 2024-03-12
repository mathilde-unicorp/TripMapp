//
//  RefugesViewModel.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 29/08/2023.
//

import Foundation
import SwiftUI
import MapKit

enum TripMapMarker: Equatable, Hashable {
    case mkMapItem(MKMapItem)
    case marker(MapMarkerModel)
}

extension TripMapMarker: Identifiable {
    var id: Int {
        switch self {
        case .mkMapItem(let item):
            return item.hash
        case .marker(let item):
            return item.id
        }
    }
}

class RefugesViewModel: ObservableObject {
    // MARK: Private properties

    private let router: AppRouter
    private let repository: TripMapItemsRepository

    // MARK: - UI Properties

    @Published var mapItemsResults: [TripMapMarker] = []

    private var defaultRegion: MKCoordinateRegion = .france
    var visibleRegion: MKCoordinateRegion?

    // MARK: - Init

    init(
        dataProvider: RefugesInfoDataProviderProtocol,
        router: AppRouter
    ) {
        self.repository = .init(dataProvider: dataProvider)
        self.router = router
    }

    // MARK: - Requests

    @MainActor
    func searchMapItems(of types: Set<PointsOfInterestType>) {
        Task {
            let region = visibleRegion ?? defaultRegion
            self.mapItemsResults = []

            try await Array(types).concurrentForEach { type in
                let items = try await self.repository
                    .searchMapItems(type: type, region: region)

                self.mapItemsResults.append(contentsOf: items)
            }
        }
    }

    @MainActor
    func searchMapItems(of type: PointsOfInterestType) {
        Task {
            let markers = try await self.repository.searchMapItems(
                type: type,
                region: visibleRegion ?? defaultRegion
            )

            self.mapItemsResults = markers
        }
    }

    // -------------------------------------------------------------------------
    // MARK: - Requests
    // -------------------------------------------------------------------------

//    private func loadMassifsPolygons() async throws -> [MapPolygonModel] {
//        let massifs = try await dataProvider.loadMassifs(
//            type: .zone,
//            massif: nil,
//            bbox: visibleRegion?.toBbox
//        )
//
//        let polygons = massifs.features.map {
//            MapPolygonModel(massif: $0)
//        }
//
//        return polygons
//    }

    // -------------------------------------------------------------------------
    // MARK: - Router
    // -------------------------------------------------------------------------

    func createRefugeDetailView(refugeId: Int) -> RefugeDetailView {
        router.createRefugeDetailView(refugeId: refugeId)
    }
}
