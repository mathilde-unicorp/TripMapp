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

    func toTripMapMarkerViewModels(type: POIType) -> [TripMapMarker.ViewModel] {
        let refugesInfoMarkers = TripMapMarker.ViewModel
            .buildMarkers(from: refugesInfoResults)

        let mkMapItemsMarkers = TripMapMarker.ViewModel
            .buildMarkers(from: mkMapItemResults, type: type)

        return refugesInfoMarkers + mkMapItemsMarkers
    }
}

// =============================================================================
// MARK: - MapItemResultsByPOIType
// =============================================================================

/// Group results of map items search by the type searched
typealias MapItemResultsByPOIType = [POIType: MapItemResults]

extension MapItemResultsByPOIType {

    // -------------------------------------------------------------------------
    // MARK: - Mutating methods
    // -------------------------------------------------------------------------

    mutating func insert(results: MapItemResults, for type: POIType) {
        self[type] = results
    }

    // -------------------------------------------------------------------------
    // MARK: - Conversion methods
    // -------------------------------------------------------------------------

    func toTripMapMarkerViewModels() -> [TripMapMarker.ViewModel] {
        self.keys.map { poiType -> [TripMapMarker.ViewModel] in
            return self[poiType]?.toTripMapMarkerViewModels(type: poiType) ?? []
        }.flatMap { $0 }
    }
}
