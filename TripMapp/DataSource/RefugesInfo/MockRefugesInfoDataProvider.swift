//
//  MockRefugesInfoData.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 24/08/2023.
//

import Foundation

final class MockRefugesInfoDataProvider: ObservableObject, RefugesInfoDataProviderProtocol {
    // -------------------------------------------------------------------------
    // MARK: - Refuges
    // -------------------------------------------------------------------------

    func loadRefuge(id: RefugeId) async throws -> RefugesInfo.RefugePoint {
        return MockRefuges.refuges[0]
    }

    func loadRefuges(
        massif: RefugesInfo.Massif,
        type: RefugesInfo.PointType?
    ) async throws -> RefugesInfo.RefugesLightPointResponse {
        let lightPoints = MockRefuges.refuges.map { $0.toLightPoint }
        return .init(features: lightPoints)
    }

    // -------------------------------------------------------------------------
    // MARK: - Massifs
    // -------------------------------------------------------------------------

    func loadMassifs(type: RefugesInfo.MassifType) async throws -> RefugesInfo.MassifsResponse {
        return .init(features: MockMassifs.massifs)
    }
}
