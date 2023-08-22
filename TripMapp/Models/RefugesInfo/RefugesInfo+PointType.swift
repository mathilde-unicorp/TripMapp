//
//  RefugesInfo+PointType.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 22/08/2023.
//

import Foundation
import SwiftUI

enum RefugePointType: Int, Codable, CaseIterable {
    case crossingPoint = 3
    case summit = 6
    case hut = 7
    case bedAndBreakfast = 9
    case refuge = 10
    case bivouac = 19
    case water = 23
    case lake = 16

    var name: String {
        switch self {
        case .hut: return "cabane"
        case .refuge: return "refuge"
        case .bedAndBreakfast: return "gite"
        case .water: return "pt_eau"
        case .summit: return "sommet"
        case .crossingPoint: return "pt_passage"
        case .bivouac: return "bivouac"
        case .lake: return "lac"
        }
    }
}

// MARK: - UI Related

extension RefugePointType {

    var icon: Image {
        switch self {
        case .hut:
            return Image(systemName: "house")
        case .refuge:
            return Image(systemName: "building.2")
        case .bedAndBreakfast:
            return Image(systemName: "bed.double")
        case .water:
            return Image(systemName: "drop")
        case .summit:
            return Image(systemName: "mountain.2")
        case .crossingPoint:
            return Image(systemName: "arrow.up.and.down")
        case .bivouac:
            return Image(systemName: "tent")
        case .lake:
            return Image(systemName: "water.waves")
        }
    }
}

extension RefugesInfo {

    struct PointType: Codable {
        let id: Int
        let value: String
        let iconName: String

        var icon: Image {
            let type = RefugePointType(rawValue: id)
            return type?.icon ?? Image(systemName: "house")
        }

        enum CodingKeys: String, CodingKey {
            case id
            case value = "valeur"
            case iconName = "icone"
        }

        init(id: Int, value: String, iconName: String) {
            self.id = id
            self.value = value
            self.iconName = iconName
        }

        init(value: RefugePointType) {
            self.id = value.rawValue
            self.value = value.name
            self.iconName = ""
        }
    }

}
