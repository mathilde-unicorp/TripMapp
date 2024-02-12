//
//  MapPointType.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 12/02/2024.
//

import Foundation

/// Enum representing the different kind of point that can be present on a map
enum MapPointType: CaseIterable {
    case crossingPoint
    case refuge
    case summit
    case hut
    case bedAndBreakfast
    case bivouac
    case water
    case lake

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

    init?(refugesInfoId: Int) {
        if let id = MapPointType.allCases.first(where: { $0.refugesInfoId == refugesInfoId }) {
            self = id
        } else { return nil }
    }
}

extension MapPointType {

    // -------------------------------------------------------------------------
    // MARK: - Refuges Info
    // -------------------------------------------------------------------------

    var toRefugesInfoPointType: RefugesInfo.PointType {
        return RefugesInfo.PointType(id: refugesInfoId, value: refugesInfoValue, iconName: systemIconName)
    }

    var refugesInfoId: Int {
        switch self {
        case .crossingPoint: return 3
        case .refuge: return 10
        case .summit: return 6
        case .hut: return 7
        case .bedAndBreakfast: return 9
        case .bivouac: return 19
        case .water: return 23
        case .lake: return 16
        }
    }

    var refugesInfoValue: String {
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

}
