//
//  TripMapItemsRepository.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 11/03/2024.
//

import Foundation
import MapKit

// =============================================================================
// MARK: - Repository Index
// =============================================================================

protocol TripMapItemsRepositoryProtocol {

    /// Search map items that matches the different pointOfInterest types in the given region
    func searchMapItems(
        types: [TripPointType],
        region: MKCoordinateRegion
    ) async throws -> MapItemResultsByTripPointType

    /// Search map items that matches the pointOfInterest type in the given region
    func searchMapItems(
        type: TripPointType,
        region: MKCoordinateRegion
    ) async throws -> MapItemResults

}

// =============================================================================
// MARK: - Repository
// =============================================================================

final class TripMapItemsRepository: ObservableObject, TripMapItemsRepositoryProtocol {

    // -------------------------------------------------------------------------
    // MARK: - Static properties
    // -------------------------------------------------------------------------

    static let shared = TripMapItemsRepository(
        refugesInfoDataProvider: RefugesInfoDataProvider()
    )

    static let mock = TripMapItemsRepository(
        refugesInfoDataProvider: MockRefugesInfoDataProvider()
    )

    // -------------------------------------------------------------------------
    // MARK: - Init
    // -------------------------------------------------------------------------

    private let refugesInfoDataProvider: RefugesInfoDataProviderProtocol

    private init(refugesInfoDataProvider: RefugesInfoDataProviderProtocol) {
        self.refugesInfoDataProvider = refugesInfoDataProvider
    }

    // -------------------------------------------------------------------------
    // MARK: - Requests
    // -------------------------------------------------------------------------

    // MARK: - PointsOfInterestsType

    /// Search map items that matches the different pointOfInterest types in the given region
    func searchMapItems(
        types: [TripPointType],
        region: MKCoordinateRegion
    ) async throws -> MapItemResultsByTripPointType {
        let concurrentResults = try await types.concurrentMap { type in
            let items = try await self.searchMapItems(type: type, region: region)
            return [type: items]
        }

        // Concurrent results returns an array, we need to flatten it.
        let otherResult = concurrentResults.reduce(into: MapItemResultsByTripPointType()) { result, item in
            item.keys.forEach { key in
                result[key] = item[key]
            }
        }

        return otherResult
    }

    /// Search map items that matches the pointOfInterest type in the given region
    func searchMapItems(
        type: TripPointType,
        region: MKCoordinateRegion
    ) async throws -> MapItemResults {
        let refugesInfoMapItems = try await searchRefugesInfoMapItems(type: type, region: region)
        let mkLocalSearchMapItems = try await searchMkLocalSearchMapItems(type: type, region: region)

        return MapItemResults(
            refugesInfoResults: refugesInfoMapItems,
            mkMapItemResults: mkLocalSearchMapItems
        )
    }

    // =============================================================================
    // MARK: - Private methods
    // =============================================================================

    private func searchRefugesInfoMapItems(
        type: TripPointType,
        region: MKCoordinateRegion
    ) async throws -> [RefugesInfo.LightRefugePoint] {
        guard let refugesInfoPointType = type.toRefugesInfoPointType else {
            return []
        }

        return try await self.refugesInfoSearch(pointType: refugesInfoPointType, region: region)
    }

    // swiftlint:disable cyclomatic_complexity function_body_length
    private func searchMkLocalSearchMapItems(
        type: TripPointType,
        region: MKCoordinateRegion
    ) async throws -> [MKMapItem] {
        switch type {
        case .foodstuffProvisions:
            try await self.mkLocalSearch(
                query: "épicerie", including: [.foodMarket], region: region
            )
        case .sportsProvisions:
            try await self.mkLocalSearch(
                query: "sport", including: [.store], region: region
            )
        case .laundryRoom:
            try await self.mkLocalSearch(
                query: "laverie", including: [.laundry], region: region
            )
        case .restaurant:
            try await self.mkLocalSearch(
                query: "restaurant", including: [.bakery, .restaurant], region: region
            )
        case .pharmacy:
            try await self.mkLocalSearch(
                query: "pharmacie", including: [.pharmacy], region: region
            )
        case .postOffice:
            try await self.mkLocalSearch(
                query: "poste", including: [.postOffice], region: region
            )
        case .bank:
            try await self.mkLocalSearch(
                query: "banque", including: [.bank], region: region
            )
        case .publicTransport:
            try await self.mkLocalSearch(
                query: "gare", including: [.publicTransport], region: region
            )
        case .restroom:
            try await self.mkLocalSearch(
                query: "toilettes", including: [.restroom], region: region
            )
        case .breakSpot:
            try await self.mkLocalSearch(
                query: "loisir", including: [.cafe, .brewery, .movieTheater], region: region
            )
        case .campground:
            try await self.mkLocalSearch(
                query: "camping", including: [.campground], region: region
            )
        case .hotel:
            try await self.mkLocalSearch(
                query: "hotel", including: [.hotel], region: region
            )
        default: []
        }
    }
    // swiftlint:enable cyclomatic_complexity function_body_length

    // -------------------------------------------------------------------------
    // MARK: - Low level requests
    // -------------------------------------------------------------------------

    private func mkLocalSearch(
        query: String,
        including categories: [MKPointOfInterestCategory],
        region: MKCoordinateRegion
    ) async throws -> [MKMapItem] {
        return try await mkLocalSearch(
            query: query,
            filter: .init(including: categories),
            region: region
        )
    }

    private func mkLocalSearch(
        query: String,
        filter: MKPointOfInterestFilter,
        region: MKCoordinateRegion
    ) async throws -> [MKMapItem] {
        // TODO: I think this one request a dataProvider on its own
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        request.resultTypes = .pointOfInterest
        request.pointOfInterestFilter = filter
        request.region = region

        let search = MKLocalSearch(request: request)
        let response = try? await search.start()

        return response?.mapItems ?? []
    }

    private func refugesInfoSearch(
        pointType: RefugesInfo.PointType,
        region: MKCoordinateRegion
    ) async throws -> [RefugesInfo.LightRefugePoint] {
        let refuges = try await refugesInfoDataProvider.loadRefuges(
            type: pointType,
            bbox: region.toBbox
        )

        return refuges.features
    }

}
