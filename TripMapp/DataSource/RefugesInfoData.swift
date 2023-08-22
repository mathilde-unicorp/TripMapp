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

            guard let refuge = response.features.first else {
                throw NetworkError.invalidData
            }

            return refuge
        } catch {
            print("Invalid data: \(error)")
            throw error
        }
    }

    func loadRefuges(type: RefugePointType? = nil) async throws -> [RefugesInfo.Refuge] {
        let urlString = "\(baseURL)massif?massif=351&type_points=\(type?.name ?? "all")&"//nb_points=22

        guard let url = urlString.toURL else {
            throw NetworkError.invalidURL(url: urlString)
        }

        do {
            let response: RefugesInfo.RefugeResponse<RefugesInfo.Point> = try await url.get()

            return response.features
        } catch {
            print("Invalid data: \(error)")
            throw error
        }
    }
}

final class MockRefugesInfoData: ObservableObject, RefugesInfoDataProtocol {
    func loadRefuge(id: String) async throws -> RefugesInfo.Refuge {
        return RefugesInfo.Feature(
            properties: RefugesInfo.Point(id: 42, name: "Quarante-Deux", type: .init(value: .bivouac)),
            geometry: RefugesInfo.Geometry(coordinates: [0.0, 0.0])
        )
    }
}
