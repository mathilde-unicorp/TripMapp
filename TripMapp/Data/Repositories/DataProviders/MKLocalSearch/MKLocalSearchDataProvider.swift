//
//  MKLocalSearchDataProvider.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 06/09/2024.
//

import MapKit

/// Data Provider wrapping search into Apple map database (MKLocalSearch)
///
/// See official doc: https://developer.apple.com/documentation/mapkit/mklocalsearch
class MKLocalSearchDataProvider {

    /// Search for a particular `query` (ex: "restaurant", "parking", ...)
    /// into some specific `categories`, only in a given `region`
    func search(
        query: String,
        including categories: [MKPointOfInterestCategory],
        region: MKCoordinateRegion
    ) async throws -> [MKMapItem] {
        return try await search(
            query: query,
            filter: .init(including: categories),
            region: region
        )
    }

    /// Search for a particular `query` (ex: "restaurant", "parking", ...)
    /// filtering result with the `filer`, only in a given `region`
    func search(
        query: String,
        filter: MKPointOfInterestFilter,
        region: MKCoordinateRegion
    ) async throws -> [MKMapItem] {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        request.resultTypes = .pointOfInterest
        request.pointOfInterestFilter = filter
        request.region = region

        let search = MKLocalSearch(request: request)
        let response = try? await search.start()

        return response?.mapItems ?? []
    }
}
