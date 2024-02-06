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

    func loadRefuge(id: Int) async throws -> RefugesInfo.RefugePoint {
        print("Load refuge id: \(id)")

        let endpoint = RefugesInfoEndpoint(path: "point", queryItems: [
            URLQueryItem(name: "id", value: id.toString),
            URLQueryItem(name: "format", value: "geojson"),
            URLQueryItem(name: "detail", value: "complet"),
        ])

        let response: RefugesInfo.RefugeResponse<RefugesInfo.Point> = try await endpoint.get(
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
    ) async throws -> [RefugesInfo.LightRefugePoint] {
        let massifValue = massif.rawValue
        let typeValue = type?.value ?? "all"

        let endpoint = RefugesInfoEndpoint(path: "massif", queryItems: [
            URLQueryItem(name: "massif", value: massifValue.toString),
            URLQueryItem(name: "type_points", value: typeValue),
            URLQueryItem(name: "nb_points", value: "100")
        ])

        let response: RefugesInfo.RefugeResponse<RefugesInfo.LightPoint> = try await endpoint.get(
            session: session
        )

        return response.features
    }
}
