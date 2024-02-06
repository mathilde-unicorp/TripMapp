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
    let description: String
    let url: URL
    let coordinate: CLLocationCoordinate2D
    let accessDescription: String
    let placeID: Int
    let icon: Image
}

// =============================================================================
// MARK: - Build
// =============================================================================

extension RefugeDescriptionViewModel {

    static func build(from refuge: RefugesInfo.RefugePoint) -> Self {
        return RefugeDescriptionViewModel(
            name: refuge.properties.name,
            description: refuge.properties.description.value,
            url: refuge.properties.link,
            coordinate: refuge.geometry.coordinated2D,
            accessDescription: refuge.properties.access.value,
            placeID: refuge.properties.id,
            icon: refuge.properties.type.icon
        )
    }

}

// =============================================================================
// MARK: - Mock
// =============================================================================

extension RefugeDescriptionViewModel {

    static func mock() -> Self {
        let name = "Gite de la Colle St Michel"
        let description = """
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
            description: description,
            url: .giteDeLaColleStMichel,
            coordinate: .giteDeLaColleStMichel,
            accessDescription: access,
            placeID: placeId,
            icon: placeIcon
        )
    }
}
