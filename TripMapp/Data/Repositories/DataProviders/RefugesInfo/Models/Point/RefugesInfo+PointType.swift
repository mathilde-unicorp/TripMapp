//
//  RefugesInfo+PointType.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 22/08/2023.
//

import Foundation
import SwiftUI

extension RefugesInfo {

    // MARK: - Point Type Structure

    struct PointType: Codable, Hashable {
        let id: Int
        let value: String
        let image: String

        var systemImage: String? {
            PointTypeById(rawValue: self.id)?.systemImage
        }

        // MARK: - Coding Keys

        enum CodingKeys: String, CodingKey {
            case id
            case value = "valeur"
            case image = "icone"
        }
    }
}

extension RefugesInfo.PointType: Equatable {
    static func == (lhs: RefugesInfo.PointType, rhs: RefugesInfo.PointType) -> Bool {
        return lhs.id == rhs.id
    }
}

// =============================================================================
// MARK: - Default values
// =============================================================================

extension RefugesInfo.PointType {

    // Make an easy usable list of point type that can be used with autocompletion :)

    static let crossingPoint = PointTypeById.crossingPoint.buildPointType()
    static let refuge = PointTypeById.refuge.buildPointType()
    static let summit = PointTypeById.summit.buildPointType()
    static let hut = PointTypeById.hut.buildPointType()
    static let bedAndBreakfast = PointTypeById.bedAndBreakfast.buildPointType()
    static let bivouac = PointTypeById.bivouac.buildPointType()
    static let water = PointTypeById.water.buildPointType()
    static let lake = PointTypeById.lake.buildPointType()

    static let allTypes = RefugesInfo.PointType.PointTypeById.allCases.map {
        $0.buildPointType()
    }
}

// =============================================================================
// MARK: - Private - Default values builder
// =============================================================================

extension RefugesInfo.PointType {

    /// List of existing (and known) point types on RefugesInfo
    private enum PointTypeById: Int, CaseIterable {
        case crossingPoint = 3
        case summit = 6
        case hut = 7
        case bedAndBreakfast = 9
        case refuge = 10
        case lake = 16
        case bivouac = 19
        case water = 23

        var systemImage: String {
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

        func buildPointType() -> RefugesInfo.PointType {
            return .init(id: self.rawValue, value: self.value, image: self.systemImage)
        }
    }
}
