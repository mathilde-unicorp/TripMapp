//
//  RefugeAccomodation.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 07/02/2024.
//

import Foundation
import SwiftUI

enum RefugeEquipment: Int, CaseIterable {
    case missingWall = 0
    case fireplace
    case stove
    case blankets
    case toilets
    case wood
    case water
}

extension RefugeEquipment {
    var imageSystemName: String {
        switch self {
        case .missingWall: return "squareshape.dotted.split.2x2"
        case .fireplace: return "fireplace"
        case .stove: return "stove"
        case .blankets: return "line.3.horizontal"
        case .toilets: return "toilet"
        case .wood: return "tree"
        case .water: return "drop"
        }
    }

    var title: LocalizedStringKey {
        switch self {
        case .blankets: return "accommodations.blankets"// "Couvertures"
        case .fireplace: return "accommodations.fireplace"// "Cheminée"
        case .missingWall: return "accommodations.missing_wall"//  "Manque un mur"
        case .stove: return "accommodations.stove"
        case .toilets: return "accommodations.toilets"
        case .water: return "accommodations.water"
        case .wood: return "accommodations.wood"
        }
    }

    var presentColor: Color {
        switch self {
        case .missingWall: return .orange
        default: return .green
        }
    }
}
