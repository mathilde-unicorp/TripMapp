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
    let title: String
    let description: String
    let coordinate: CLLocationCoordinate2D
    let access: String
    let placeID: Int
    let icon: Image

    static func build(from refuge: RefugesInfo.RefugePoint) -> Self {
        return RefugeDescriptionViewModel(
            title: refuge.properties.name,
            description: refuge.properties.description.value,
            coordinate: refuge.geometry.coordinated2D,
            access: refuge.properties.access.value,
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
        let title = "Mock Place"
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
        let coordinate = CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194)
        let access = "Mock access information"
        let placeId = 1234
        let placeIcon = Image(systemName: "tent")

        return RefugeDescriptionViewModel(
            title: title,
            description: description,
            coordinate: coordinate,
            access: access,
            placeID: placeId,
            icon: placeIcon
        )
    }
}
