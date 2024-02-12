//
//  RefugesInfoData.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 04/05/2023.
//

import Foundation

// https://www.refuges.info/api/doc/

final class RefugesInfoDataProvider: ObservableObject {

    private let session: URLSession

    // -------------------------------------------------------------------------
    // MARK: - Init
    // -------------------------------------------------------------------------

    init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 60
        self.session = URLSession(configuration: configuration)
    }
}

extension RefugesInfoDataProvider: RefugesInfoDataProviderProtocol {

    // -------------------------------------------------------------------------
    // MARK: - Refuges
    // -------------------------------------------------------------------------

    func loadRefuge(id: RefugeId) async throws -> RefugesInfo.RefugePoint {
        print("Load refuge id: \(id)")

        let endpoint = RefugesInfoEndpoint(path: "point", queryItems: [
            URLQueryItem(name: "id", value: id.toString),
            URLQueryItem(name: "format", value: "geojson"),
            URLQueryItem(name: "detail", value: "complet"),
        ])

        let response: RefugesInfo.RefugesPointResponse = try await endpoint.get(
            session: session
        )

        guard let refuge = response.features.first else {
            throw NetworkError.invalidData
        }

        return refuge
    }

    func loadRefuges(
        massif: RefugesInfo.Massif = .pyrenees,
        type: RefugesInfo.PointType? = nil
    ) async throws -> RefugesInfo.RefugesLightPointResponse {
        let massifValue = massif.rawValue
        let typeValue = type?.value ?? "all"

        print("Load refuges with point type: \(typeValue)")

        let endpoint = RefugesInfoEndpoint(path: "massif", queryItems: [
            URLQueryItem(name: "massif", value: massifValue.toString),
            URLQueryItem(name: "type_points", value: typeValue),
            URLQueryItem(name: "nb_points", value: "100")
        ])

        return try await endpoint.get(session: session)
    }

    func loadMassifs(
        type: RefugesInfo.MassifType
    ) async throws -> RefugesInfo.MassifsResponse {
        let endpoint = RefugesInfoEndpoint(path: "polygones", queryItems: [
            URLQueryItem(name: "format", value: "geojson"),
            URLQueryItem(name: "type_polygon", value: type.rawValue.toString)
        ])

        return try await endpoint.get(session: session)
    }
}
