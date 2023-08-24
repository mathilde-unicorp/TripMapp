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
    func loadRefuge(id: Int) async throws -> RefugesInfo.RefugePoint
    func loadRefuges(type: RefugesInfo.PointType?) async throws -> [RefugesInfo.LightRefugePoint]
}

// https://www.refuges.info/api/doc/

final class RefugesInfoData: ObservableObject {

    let baseURL = "https://www.refuges.info/api/"

    // MARK - Load Refuge

    func loadRefuge(id: Int) async throws -> RefugesInfo.RefugePoint {
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

    func loadRefuges(type: RefugesInfo.PointType? = nil) async throws -> [RefugesInfo.LightRefugePoint] {
        let urlString = "\(baseURL)massif?massif=351&type_points=\(type?.value ?? "all")"//&nb_points=22

        guard let url = urlString.toURL else {
            throw NetworkError.invalidURL(url: urlString)
        }

        do {
            let response: RefugesInfo.RefugeResponse<RefugesInfo.LightPoint> = try await url.get()

            return response.features
        } catch {
            print("Invalid data: \(error)")
            throw error
        }
    }
}
