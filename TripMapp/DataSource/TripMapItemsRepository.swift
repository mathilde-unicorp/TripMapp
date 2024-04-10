//
//  TripMapItemsRepository.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 11/03/2024.
//

import Foundation
import MapKit

struct MapItemSearchResults {
    let refugesInfoResults: [RefugesInfo.LightRefugePoint]
    let mkMapItemResults: [MKMapItem]
}

class TripMapItemsRepository {

    let dataProvider: RefugesInfoDataProviderProtocol

    init(dataProvider: RefugesInfoDataProviderProtocol) {
        self.dataProvider = dataProvider
    }

    // -------------------------------------------------------------------------
    // MARK: - Requests
    // -------------------------------------------------------------------------

    // MARK: - PointsOfInterestsType

    func searchMapItems(
        type: PointsOfInterestType,
        region: MKCoordinateRegion
    ) async throws -> MapItemSearchResults {
        let refugesInfoMapItems = try await searchRefugesInfoMapItems(type: type, region: region)
        let mkLocalSearchMapItems = try await searchMkLocalSearchMapItems(type: type, region: region)

        return MapItemSearchResults(
            refugesInfoResults: refugesInfoMapItems,
            mkMapItemResults: mkLocalSearchMapItems
        )
    }

    private func searchRefugesInfoMapItems(
        type: PointsOfInterestType,
        region: MKCoordinateRegion
    ) async throws -> [RefugesInfo.LightRefugePoint] {
        switch type {
        case .summit:
            try await self.refugesInfoSearch(pointType: .summit, region: region)
        case .waypoint:
            try await self.refugesInfoSearch(pointType: .crossingPoint, region: region)
        case .water:
            try await self.refugesInfoSearch(pointType: .water, region: region)
        case .lake:
            try await self.refugesInfoSearch(pointType: .lake, region: region)
        case .refuge:
            try await self.refugesInfoSearch(pointType: .refuge, region: region)
        case .cottage:
            try await self.refugesInfoSearch(pointType: .bedAndBreakfast, region: region)
        case .bivouac:
            try await self.refugesInfoSearch(pointType: .bivouac, region: region)
        default: []
        }
    }

    // swiftlint:disable cyclomatic_complexity function_body_length
    private func searchMkLocalSearchMapItems(
        type: PointsOfInterestType,
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
        let refuges = try await dataProvider.loadRefuges(
            type: pointType,
            bbox: region.toBbox
        )

        return refuges.features
    }

}
