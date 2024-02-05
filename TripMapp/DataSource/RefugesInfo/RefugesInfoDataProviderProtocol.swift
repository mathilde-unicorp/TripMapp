//
//  RefugesInfoDataProviderProtocol.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 05/02/2024.
//

import Foundation

protocol RefugesInfoDataProviderProtocol {
    func loadRefuge(id: Int) async throws -> RefugesInfo.RefugePoint

    func loadRefuges(
        massif: RefugesInfo.Massif,
        type: RefugesInfo.PointType?
    ) async throws -> [RefugesInfo.LightRefugePoint]
}
