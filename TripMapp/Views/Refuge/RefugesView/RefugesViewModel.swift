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
    private let repository: TripMapItemsRepository

    // MARK: - UI Properties

    @Published var markers: [TripMapMarker.ViewModel] = []

    @Published var courses: [CourseLayer.ViewModel] = []

    private var defaultRegion: MKCoordinateRegion = .france
    var visibleRegion: MKCoordinateRegion?

    // MARK: - Init

    init(
        dataProvider: RefugesInfoDataProviderProtocol,
        router: AppRouter
    ) {
        self.repository = .init(dataProvider: dataProvider)
        self.router = router

        self.courses = [
            .init(gpxUrl: .gr66Gpx),
            .init(gpxUrl: .gr70Gpx)
//            .init(gpxUrl: .tourDuLacDesPisesGpx)
        ]
    }

    // MARK: - Requests

    @MainActor
    func searchMapItems(of types: Set<PointsOfInterestType>) {
        Task {
            let region = visibleRegion ?? defaultRegion

            self.markers = []

            try await Array(types).concurrentForEach { type in
                let items = try await self.repository
                    .searchMapItems(type: type, region: region)

                self.markers.append(
                    contentsOf: items.refugesInfoResults.map {
                        TripMapMarker.ViewModel(refugeInfoResult: $0, type: type)
                    }
                )

                self.markers.append(
                    contentsOf: items.mkMapItemResults.map {
                        TripMapMarker.ViewModel(mkMapItem: $0, type: type)
                    }
                )
            }
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
