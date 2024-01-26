//
//  RefugesInfoData.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 04/05/2023.
//

import Foundation

enum NetworkError: Error {
    case invalidURL(url: String)
    case invalidData
}

protocol RefugesInfoDataProviderProtocol {
    func loadRefuge(id: Int) async throws -> RefugesInfo.RefugePoint

    func loadRefuges(
        massif: RefugesInfo.DefaultMassif,
        type: RefugesInfo.PointType?
    ) async throws -> [RefugesInfo.LightRefugePoint]
}

// https://www.refuges.info/api/doc/

final class RefugesInfoDataProvider: ObservableObject, RefugesInfoDataProviderProtocol {

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

    // -------------------------------------------------------------------------
    // MARK: - Refuges
    // -------------------------------------------------------------------------

    func loadRefuge(id: Int) async throws -> RefugesInfo.RefugePoint {
        print("Load refuge id: \(id)")

        let endpoint = Endpoint(path: "point", queryItems: [
            URLQueryItem(name: "id", value: id.toString),
            URLQueryItem(name: "format", value: "geojson"),
            URLQueryItem(name: "detail", value: "complet"),
        ])

        let response: RefugesInfo.RefugeResponse<RefugesInfo.Point> = try await self.get(
            endpoint: endpoint
        )

        guard let refuge = response.features.first else {
            throw NetworkError.invalidData
        }

        return refuge
    }

    func loadRefuges(
        massif: RefugesInfo.DefaultMassif = .pyrenees,
        type: RefugesInfo.PointType? = nil
    ) async throws -> [RefugesInfo.LightRefugePoint] {
        let massifValue = massif.rawValue
        let typeValue = type?.value ?? "all"

        let endpoint = Endpoint(path: "massif", queryItems: [
            URLQueryItem(name: "massif", value: massifValue.toString),
            URLQueryItem(name: "type_points", value: typeValue),
            URLQueryItem(name: "nb_points", value: "100")
        ])

        let response: RefugesInfo.RefugeResponse<RefugesInfo.LightPoint> = try await self.get(
            endpoint: endpoint
        )
        return response.features
    }

    // -------------------------------------------------------------------------
    // MARK: - Tools
    // -------------------------------------------------------------------------

    private func get<T: Codable>(endpoint: Endpoint) async throws -> T {
        guard let url = endpoint.buildURL() else {
            throw NetworkError.invalidURL(url: endpoint.path)
        }

        do {
            return try await url.get(session: session)
        } catch {
            print("Invalid data: \(error)")
            throw error
        }
    }
}
