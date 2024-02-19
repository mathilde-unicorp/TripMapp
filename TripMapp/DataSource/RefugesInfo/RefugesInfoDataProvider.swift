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
        massif: RefugesInfo.MassifId,
        type: RefugesInfo.PointType?,
        bbox: RefugesInfo.Bbox?
    ) async throws -> RefugesInfo.RefugesLightPointResponse {
        let typeValue = type?.value ?? "all"

        print("Load refuges with point type: \(typeValue)")

        let endpoint = RefugesInfoEndpoint(path: "massif", queryItems: [
            URLQueryItem(name: "massif", value: massif),
            URLQueryItem(name: "type_points", value: typeValue),
            URLQueryItem(name: "nb_points", value: "100"),
            URLQueryItem(name: "bbox", value: bbox?.description)
        ])

        return try await endpoint.get(session: session)
    }

    func loadRefuges(
        type: RefugesInfo.PointType?,
        bbox: RefugesInfo.Bbox?
    ) async throws -> RefugesInfo.RefugesLightPointResponse {
        let typeValue = type?.value ?? "all"

        print("Load refuges with point type: \(typeValue)")

        let endpoint = RefugesInfoEndpoint(path: "bbox", queryItems: [
            URLQueryItem(name: "type_points", value: typeValue),
            URLQueryItem(name: "nb_points", value: "100"),
            URLQueryItem(name: "bbox", value: bbox?.description)
        ])

        return try await endpoint.get(session: session)
    }

    func loadMassifs(
        type: RefugesInfo.MassifType,
        massif: RefugesInfo.MassifId?,
        bbox: RefugesInfo.Bbox?
    ) async throws -> RefugesInfo.MassifsResponse {
        let endpoint = RefugesInfoEndpoint(path: "polygones", queryItems: [
            URLQueryItem(name: "massif", value: massif),
            URLQueryItem(name: "format", value: "geojson"),
            URLQueryItem(name: "type_polygon", value: type.rawValue),
            URLQueryItem(name: "bbox", value: bbox?.description),
        ])

        return try await endpoint.get(session: session)
    }
}
