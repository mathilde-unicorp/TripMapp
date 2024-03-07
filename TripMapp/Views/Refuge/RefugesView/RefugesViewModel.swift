//
//  RefugesViewModel.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 29/08/2023.
//

import Foundation
import SwiftUI
import MapKit
import Unicorp_DataTypesLibrary

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
    private let dataProvider: RefugesInfoDataProviderProtocol

    // MARK: - UI Properties

    @Published var mapItemsResults: [TripMapMarker] = []

    private var defaultRegion: MKCoordinateRegion = .france
    var visibleRegion: MKCoordinateRegion?

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
    func searchMapItems(serviceType: ServicesPointsOfInterests) {
        self.searchMapItems(
            query: serviceType.defaultQuery,
            filter: serviceType.mkPointOfInterestFilter
        )
    }

    @MainActor
    func searchMapItems(accomodationType: AccomodationsPointsOfInterests) {
        switch accomodationType {
        case .refuge:
            self.searchMapItems(type: .refuge)
        case .cottage:
            self.searchMapItems(type: .bedAndBreakfast)
        case .campground, .hotel:
            self.searchMapItems(
                query: accomodationType.defaultQuery,
                filter: accomodationType.mkPointOfInterestFilter
            )
        }
    }

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

            self.mapItemsResults = response?.mapItems.map {
                TripMapMarker.mkMapItem($0)
            } ?? []
        }
    }

    private func searchMapItems(type: RefugesInfo.PointType) {
        Task {
            let refuges = try await dataProvider.loadRefuges(
                type: type,
                bbox: visibleRegion?.toBbox
            )

            let items = refuges.features.map {
                TripMapMarker.marker(.init(refuge: $0))
            }

            self.mapItemsResults = items
        }
    }

    private func loadMassifsPolygons() async throws -> [MapPolygonModel] {
        let massifs = try await dataProvider.loadMassifs(
            type: .zone,
            massif: nil,
            bbox: visibleRegion?.toBbox
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
