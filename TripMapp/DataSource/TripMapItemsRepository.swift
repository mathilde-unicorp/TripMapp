//
//  TripMapItemsRepository.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 11/03/2024.
//

import Foundation
import MapKit

class TripMapItemsRepository {

    let dataProvider: RefugesInfoDataProviderProtocol

    init(dataProvider: RefugesInfoDataProviderProtocol) {
        self.dataProvider = dataProvider
    }

    // -------------------------------------------------------------------------
    // MARK: - Requests
    // -------------------------------------------------------------------------

    // MARK: - PointsOfInterestsCategory

    func searchMapItems(
        category: PointsOfInterestsCategory,
        region: MKCoordinateRegion?
    ) async throws -> [TripMapMarker] {
        if let service = category as? ServicesPointsOfInterests {
            return try await searchMapItems(serviceType: service, region: region)
        } else if let hiking = category as? HikingPointsOfInterests {
            return try await searchMapItems(hikingType: hiking, region: region)
        } else if let accomodation = category as? AccomodationsPointsOfInterests {
            return try await searchMapItems(accomodationType: accomodation, region: region)
        } else {
            return []
        }
    }

    private func searchMapItems(
        serviceType: ServicesPointsOfInterests,
        region: MKCoordinateRegion?
    ) async throws -> [TripMapMarker] {
        switch serviceType {
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
                query: "loisir",
                including: [.cafe, .brewery, .movieTheater],
                region: region
            )
        }
    }

    private func searchMapItems(
        hikingType: HikingPointsOfInterests,
        region: MKCoordinateRegion?
    ) async throws -> [TripMapMarker] {
        switch hikingType {
        case .summit:
            try await self.refugesInfoSearch(pointType: .summit, region: region)
        case .waypoints:
            try await self.refugesInfoSearch(pointType: .crossingPoint, region: region)
        case .water:
            try await self.refugesInfoSearch(pointType: .water, region: region)
        case .lake:
            try await self.refugesInfoSearch(pointType: .lake, region: region)
        }
    }

    private func searchMapItems(
        accomodationType: AccomodationsPointsOfInterests,
        region: MKCoordinateRegion?
    ) async throws -> [TripMapMarker] {
        switch accomodationType {
        case .refuge:
            try await self.refugesInfoSearch(pointType: .refuge, region: region)
        case .cottage:
            try await self.refugesInfoSearch(pointType: .bedAndBreakfast, region: region)
        case .bivouac:
            try await self.refugesInfoSearch(pointType: .bivouac, region: region)
        case .campground:
            try await self.mkLocalSearch(
                query: "camping", including: [.campground], region: region
            )
        case .hotel:
            try await self.mkLocalSearch(
                query: "hotel", including: [.hotel], region: region
            )
        }
    }

    // -------------------------------------------------------------------------
    // MARK: - Low level requests
    // -------------------------------------------------------------------------

    private func mkLocalSearch(
        query: String,
        including categories: [MKPointOfInterestCategory],
        region: MKCoordinateRegion?
    ) async throws -> [TripMapMarker] {
        return try await mkLocalSearch(
            query: query,
            filter: .init(including: categories),
            region: region
        )
    }

    private func mkLocalSearch(
        query: String,
        filter: MKPointOfInterestFilter,
        region: MKCoordinateRegion?
    ) async throws -> [TripMapMarker] {
        // TODO: I think this one request a dataProvider on its own
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        request.resultTypes = .pointOfInterest
        request.pointOfInterestFilter = filter

        if let region {
            request.region = region
        }

        let search = MKLocalSearch(request: request)
        let response = try? await search.start()

        let items = response?.mapItems.map {
            TripMapMarker.mkMapItem($0)
        } ?? []

        return items
    }

    private func refugesInfoSearch(
        pointType: RefugesInfo.PointType,
        region: MKCoordinateRegion?
    ) async throws -> [TripMapMarker] {
        let refuges = try await dataProvider.loadRefuges(
            type: pointType,
            bbox: region?.toBbox
        )

        let items = refuges.features.map {
            TripMapMarker.marker(.init(refuge: $0))
        }

        return items
    }

}
