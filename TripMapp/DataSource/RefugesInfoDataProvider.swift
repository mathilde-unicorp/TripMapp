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

    let baseURL = "https://www.refuges.info/api/"

    // MARK - Load Refuge

    func loadRefuge(id: Int) async throws -> RefugesInfo.RefugePoint {
        print("Load refuge id: \(id)")
        let response: RefugesInfo.RefugeResponse<RefugesInfo.Point> = try await self.get(
            endpoint: "point?id=\(id)&format=geojson&detail=complet"
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

        let response: RefugesInfo.RefugeResponse<RefugesInfo.LightPoint> = try await self.get(
            endpoint: "massif?massif=\(massifValue)&type_points=\(typeValue)&nb_points=100"
        )
        return response.features
    }

    // -------------------------------------------------------------------------
    // MARK: - Tools
    // -------------------------------------------------------------------------

    private let session: URLSession

    init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 60
        self.session = URLSession(configuration: configuration)
    }

    private func get<T: Codable>(endpoint: String) async throws -> T {
        let urlString = "\(baseURL)\(endpoint)"

        guard let url = urlString.toURL else {
            throw NetworkError.invalidURL(url: urlString)
        }

        do {
            return try await url.get(session: session)
        } catch {
            print("Invalid data: \(error)")
            throw error
        }
    }
}
