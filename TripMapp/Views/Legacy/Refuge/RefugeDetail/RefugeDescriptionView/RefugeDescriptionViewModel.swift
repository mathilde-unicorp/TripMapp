//
//  RefugeDescriptionViewModel.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 25/08/2023.
//

import Foundation
import SwiftUI
import CoreLocation

extension RefugeDescriptionView {
    struct ViewModel {
        let name: String
        let note: String
        let url: URL
        let marker: TripPoint
        let coordinate: CLLocationCoordinate2D
        let altitude: Int
        let accessDescription: String
        let placeId: RefugeId
        let systemImage: String
        let equipments: [RefugeEquipment]
        let places: Int?
        let mattressPlaces: Int?
    }
}

// =============================================================================
// MARK: - Build
// =============================================================================

extension RefugeDescriptionView.ViewModel {

    static func build(from refuge: RefugesInfo.RefugePoint) -> Self {
        return RefugeDescriptionView.ViewModel(
            name: refuge.properties.name,
            note: refuge.properties.note.value,
            url: refuge.properties.link,
            marker: .build(from: refuge.toLightPoint),
            coordinate: refuge.geometry.coordinate2D,
            altitude: refuge.properties.coordinates.altitude,
            accessDescription: refuge.properties.access.value,
            placeId: refuge.properties.id,
            systemImage: refuge.properties.type.systemImage ?? "",
            equipments: buildEquipments(from: refuge),
            places: refuge.properties.capacity.value,
            mattressPlaces: refuge.properties.additionnalInfo.mattressPlaces.value.toInt
        )
    }

    static func buildEquipments(from refuge: RefugesInfo.RefugePoint) -> [RefugeEquipment] {
        let additionalInfo = refuge.properties.additionnalInfo
        let hasBlankets = additionalInfo.blankets.value?.toInt?.toBool ?? false
        let missingWall = additionalInfo.missingWall.value?.toInt?.toBool ?? false
        let hasWater = additionalInfo.water.value?.toInt?.toBool ?? false
        let hasToilets = additionalInfo.toilets.value?.toInt?.toBool ?? false
        let hasStove = additionalInfo.stove.value?.toInt?.toBool ?? false
        let hasWood = additionalInfo.wood.value?.toInt?.toBool ?? false
        let hasFireplace = additionalInfo.fireplace.value?.toInt?.toBool ?? false

        var equipments = [RefugeEquipment]()

        if hasBlankets { equipments.append(.blankets) }
        if missingWall { equipments.append(.missingWall) }
        if hasWater { equipments.append(.water) }
        if hasToilets { equipments.append(.toilets) }
        if hasStove { equipments.append(.stove) }
        if hasWood { equipments.append(.wood) }
        if hasFireplace { equipments.append(.fireplace) }

        return equipments
    }
}

// =============================================================================
// MARK: - Mock
// =============================================================================

extension RefugeDescriptionView.ViewModel {

    static func mock() -> Self {
        return RefugeDescriptionView.ViewModel
            .build(from: MockRefuges.refuges.first!)
    }
}
