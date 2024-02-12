//
//  RefugesInfoDataProviderProtocol.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 05/02/2024.
//

import Foundation

protocol RefugesInfoDataProviderProtocol {
    func loadRefuge(id: RefugeId) async throws -> RefugesInfo.RefugePoint

    func loadRefuges(
        massif: RefugesInfo.Massif,
        type: RefugesInfo.PointType?
    ) async throws -> RefugesInfo.RefugesLightPointResponse

    func loadMassifs(
        type: RefugesInfo.MassifType
    ) async throws -> RefugesInfo.MassifsResponse
}
