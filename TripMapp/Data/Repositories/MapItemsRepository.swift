//
//  TripMapItemsRepository.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 11/03/2024.
//

import Foundation
import MapKit

// =============================================================================
// MARK: - Repository
// =============================================================================

/// Repository providing map items requests
final class MapItemsRepository: ObservableObject {

    // -------------------------------------------------------------------------
    // MARK: - Static properties
    // -------------------------------------------------------------------------

    static let shared = MapItemsRepository(
        refugesInfoDataProvider: RefugesInfoDataProvider(),
        mkLocalSearchDataProvider: MKLocalSearchDataProvider()
    )

    static let mock = MapItemsRepository(
        refugesInfoDataProvider: MockRefugesInfoDataProvider(),
        mkLocalSearchDataProvider: MKLocalSearchDataProvider() // do not have mock yet
    )

    // -------------------------------------------------------------------------
    // MARK: - Init
    // -------------------------------------------------------------------------

    private let refugesInfoDataProvider: RefugesInfoDataProviderProtocol
    private let mkLocalSearchDataProvider: MKLocalSearchDataProvider

    private init(
        refugesInfoDataProvider: RefugesInfoDataProviderProtocol,
        mkLocalSearchDataProvider: MKLocalSearchDataProvider
    ) {
        self.refugesInfoDataProvider = refugesInfoDataProvider
        self.mkLocalSearchDataProvider = mkLocalSearchDataProvider
    }

    // -------------------------------------------------------------------------
    // MARK: - Requests
    // -------------------------------------------------------------------------

    // MARK: - PointsOfInterestsType

    /// Search map items that matches the different point `types` specified in the given`region`
    func searchMapItems(
        types: [TripPointType],
        region: MKCoordinateRegion
    ) async throws -> MapItemResultsByTripPointType {
        let concurrentResults = try await types.concurrentMap { type in
            let items = try await self.searchMapItems(type: type, region: region)
            return [type: items]
        }

        // Concurrent results returns an array, we need to flatten it.
        let otherResult = concurrentResults
            .reduce(into: MapItemResultsByTripPointType()) { result, item in
                item.keys.forEach { key in
                    result[key] = item[key]
                }
            }

        return otherResult
    }

    /// Search map items that matches the points `type` in the given `region`
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
        guard let pointType = type.toRefugesInfoPointType else {
            return []
        }

        let refuges = try await refugesInfoDataProvider.loadRefuges(
            type: pointType,
            bbox: region.toBbox
        )

        return refuges.features
    }

    private func searchMkLocalSearchMapItems(
        type: TripPointType,
        region: MKCoordinateRegion
    ) async throws -> [MKMapItem] {
        guard let query = type.toMkPointOfInterestQuery,
              let categories = type.toMkPointOfInterestCategory else {
            return []
        }

        return try await self.mkLocalSearchDataProvider.search(
            query: query, including: categories, region: region
        )
    }
}
