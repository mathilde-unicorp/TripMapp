//
//  RefugesInfo+PointType.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 22/08/2023.
//

import Foundation
import SwiftUI

extension RefugesInfo {

    // MARK: - Default Values

    enum DefaultPointType: Int {
        case crossingPoint = 3
        case refuge = 10
        case summit = 6
        case hut = 7
        case bedAndBreakfast = 9
        case bivouac = 19
        case water = 23
        case lake = 16

        var value: String {
            switch self {
            case .crossingPoint: return "pt_passage"
            case .refuge: return "refuge"
            case .summit: return "sommet"
            case .hut: return "cabane"
            case .bedAndBreakfast: return "gite"
            case .bivouac: return "bivouac"
            case .water: return "pt_eau"
            case .lake: return "lac"
            }
        }

        var systemIconName: String {
            switch self {
            case .crossingPoint: return "arrow.up.and.down"
            case .refuge: return "building.2"
            case .summit: return "mountain.2"
            case .hut: return "house"
            case .bedAndBreakfast: return "bed.double"
            case .bivouac: return "tent"
            case .water: return "drop.fill"
            case .lake: return "water.waves"
            }
        }

        var toPointType: PointType {
            return PointType(id: rawValue, value: value, iconName: systemIconName)
        }
    }

    // MARK: - Point Type Structure

    struct PointType: Codable, Hashable {
        let id: Int
        let value: String
        let iconName: String

        var icon: Image {
            if let systemIconName = DefaultPointType(rawValue: id)?.systemIconName {
                return Image(systemName: systemIconName)
            } else {
                return Image(iconName)
            }
        }

        // MARK: - Coding Keys

        enum CodingKeys: String, CodingKey {
            case id
            case value = "valeur"
            case iconName = "icone"
        }

        // MARK: - Default values

        static let crossingPoint = DefaultPointType.crossingPoint.toPointType
        static let refuge = DefaultPointType.refuge.toPointType
        static let summit = DefaultPointType.summit.toPointType
        static let hut = DefaultPointType.hut.toPointType
        static let bedAndBreakfast = DefaultPointType.bedAndBreakfast.toPointType
        static let bivouac = DefaultPointType.bivouac.toPointType
        static let water = DefaultPointType.water.toPointType
        static let lake = DefaultPointType.lake.toPointType
    }

}
