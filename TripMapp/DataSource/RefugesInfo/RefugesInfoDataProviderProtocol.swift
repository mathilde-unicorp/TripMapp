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
        massif: RefugesInfo.MassifId,
        type: RefugesInfo.PointType?,
        bbox: RefugesInfo.Bbox?
    ) async throws -> RefugesInfo.RefugesLightPointResponse

    func loadRefuges(
        type: RefugesInfo.PointType?,
        bbox: RefugesInfo.Bbox?
    ) async throws -> RefugesInfo.RefugesLightPointResponse

    func loadMassifs(
        type: RefugesInfo.MassifType,
        massif: RefugesInfo.MassifId?,
        bbox: RefugesInfo.Bbox?
    ) async throws -> RefugesInfo.MassifsResponse
}
