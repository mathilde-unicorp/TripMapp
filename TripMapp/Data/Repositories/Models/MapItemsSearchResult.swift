//
//  MapItemsSearchResult.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 03/07/2024.
//

import Foundation
import MapKit

// =============================================================================
// MARK: - MapItemResults
// =============================================================================

/// Map items search results for different sources of data
struct MapItemResults {
    let refugesInfoResults: [RefugesInfo.LightRefugePoint]
    let mkMapItemResults: [MKMapItem]

    // -------------------------------------------------------------------------
    // MARK: - Conversion methods
    // -------------------------------------------------------------------------

    func toTripPoints(type: TripPointType) -> [TripPoint] {
        let refugesInfoMarkers = TripPoint
            .buildMarkers(from: refugesInfoResults)

        let mkMapItemsMarkers = TripPoint
            .buildMarkers(from: mkMapItemResults, type: type)

        return refugesInfoMarkers + mkMapItemsMarkers
    }
}

// =============================================================================
// MARK: - MapItemResultsByTripPointType
// =============================================================================

/// Group results of map items search by the type searched
typealias MapItemResultsByTripPointType = [TripPointType: MapItemResults]

extension MapItemResultsByTripPointType {

    // -------------------------------------------------------------------------
    // MARK: - Mutating methods
    // -------------------------------------------------------------------------

    mutating func insert(results: MapItemResults, for type: TripPointType) {
        self[type] = results
    }

    // -------------------------------------------------------------------------
    // MARK: - Conversion methods
    // -------------------------------------------------------------------------

    func toTripPoints() -> [TripPoint] {
        self.keys.map { tripPointType -> [TripPoint] in
            return self[tripPointType]?.toTripPoints(type: tripPointType) ?? []
        }.flatMap { $0 }
    }
}
