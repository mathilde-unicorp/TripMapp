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

protocol RefugesInfoDataProtocol {
    func loadRefuge(id: String) async throws -> RefugesInfo.Refuge
}

final class RefugesInfoData: ObservableObject {

    let baseURL = "https://www.refuges.info/api/"

    // MARK - Load Refuge

    func loadRefuge(id: String) async throws -> RefugesInfo.Refuge {
        let urlString = "\(baseURL)point?id=\(id)&format=geojson&detail=complet"

        guard let url = urlString.toURL else {
            throw NetworkError.invalidURL(url: urlString)
        }

        do {
            let response: RefugesInfo.RefugeResponse<RefugesInfo.Point> = try await url.get()

            guard let feature = response.features.first else {
                throw NetworkError.invalidData
            }

            return feature
        } catch {
            print("Invalid data: \(error)")
            throw error
        }
    }
}

final class MockRefugesInfoData: ObservableObject, RefugesInfoDataProtocol {
    func loadRefuge(id: String) async throws -> RefugesInfo.Refuge {
        return RefugesInfo.Feature(
            properties: RefugesInfo.Point(id: 42, name: "Quarante-Deux"),
            geometry: RefugesInfo.Geometry(coordinates: [0.0, 0.0])
        )
    }
}
