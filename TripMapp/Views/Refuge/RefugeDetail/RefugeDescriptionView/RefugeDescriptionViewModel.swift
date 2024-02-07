//
//  RefugeDescriptionViewModel.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 25/08/2023.
//

import Foundation
import SwiftUI
import CoreLocation

struct RefugeDescriptionViewModel {
    let name: String
    let note: String
    let url: URL
    let coordinate: CLLocationCoordinate2D
    let altitude: Int
    let accessDescription: String
    let placeID: Int
    let icon: Image
    let accomodations: [RefugeAccomodation]
    let places: Int
    let mattressPlaces: Int
}

// =============================================================================
// MARK: - Build
// =============================================================================

extension RefugeDescriptionViewModel {

    static func build(from refuge: RefugesInfo.RefugePoint) -> Self {
        return RefugeDescriptionViewModel(
            name: refuge.properties.name,
            note: refuge.properties.note.value,
            url: refuge.properties.link,
            coordinate: refuge.geometry.coordinated2D,
            altitude: refuge.properties.coordinates.altitude,
            accessDescription: refuge.properties.access.value,
            placeID: refuge.properties.id,
            icon: refuge.properties.type.icon,
            accomodations: buildAccomodations(from: refuge),
            places: refuge.properties.capacity.value,
            mattressPlaces: refuge.properties.additionnalInfo.mattressPlaces.value.toInt ?? 0
        )
    }

    static func buildAccomodations(from refuge: RefugesInfo.RefugePoint) -> [RefugeAccomodation] {
        let additionalInfo = refuge.properties.additionnalInfo
        let hasBlankets = additionalInfo.blankets.value?.toInt?.toBool ?? false
        let missingWall = additionalInfo.missingWall.value?.toInt?.toBool ?? false
        let hasWater = additionalInfo.water.value?.toInt?.toBool ?? false
        let hasToilets = additionalInfo.toilets.value?.toInt?.toBool ?? false
        let hasStove = additionalInfo.stove.value?.toInt?.toBool ?? false
        let hasWood = additionalInfo.wood.value?.toInt?.toBool ?? false
        let hasFireplace = additionalInfo.fireplace.value?.toInt?.toBool ?? false

        var accomodations = [RefugeAccomodation]()

        if hasBlankets { accomodations.append(.blankets) }
        if missingWall { accomodations.append(.missingWall) }
        if hasWater { accomodations.append(.water) }
        if hasToilets { accomodations.append(.toilets) }
        if hasStove { accomodations.append(.stove) }
        if hasWood { accomodations.append(.wood) }
        if hasFireplace { accomodations.append(.fireplace) }

        return accomodations
    }
}

// =============================================================================
// MARK: - Mock
// =============================================================================

extension RefugeDescriptionViewModel {

    static func mock() -> Self {
        let name = "Gite de la Colle St Michel"
        let note = """
-2 Douches oui
- cuisine en libre accès oui
- Gestion libre ou demi-pension
- accessible en voiture oui

- Accueil rando :
    La nuit + petit-déjeuner est de 35.00 € par personne.
    La demi-pension, repas du soir, nuit et petit déjeuner est de 60.00 € par personnes.
    La pension complète, repas du soir, nuit, petit déjeuner et panier repas de midi est de 73.00 €.
    Dans toutes les formules les draps sont fournis.
"""
        let access = """
A pieds
Situé sur le parcours de la Grande Traversée des PréAlpes, le tour du Haut-Verdon.

En voiture
Le village est situé sur la D908.
"""
        let placeId = 1234
        let placeIcon = Image(systemName: "tent")

        return RefugeDescriptionViewModel(
            name: name,
            note: note,
            url: .giteDeLaColleStMichel,
            coordinate: .giteDeLaColleStMichel,
            altitude: 1450,
            accessDescription: access,
            placeID: placeId,
            icon: placeIcon,
            accomodations: [.blankets, .fireplace, .stove],
            places: 10,
            mattressPlaces: 6
        )
    }
}
