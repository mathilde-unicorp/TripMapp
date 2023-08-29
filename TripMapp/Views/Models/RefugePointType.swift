//
//  RefugePointType.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 29/08/2023.
//

import Foundation
import SwiftUI

enum RefugePointType: Int {
    case refuge = 0
    case hut
    case bivouac
    case bedAndBreakfast
    case summit
    case crossingPoint
    case lake
    case water

    var icon: Image {
        return Image(systemName: systemIconName)
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

    var name: String {
        switch self {
        case .crossingPoint: return "Crossing Point"
        case .refuge: return "Refuge"
        case .summit: return "Summit"
        case .hut: return "Hut"
        case .bedAndBreakfast: return "Bed & Breakfast"
        case .bivouac: return "Bivouac"
        case .water: return "Water"
        case .lake: return "Lake"
        }
    }
}

// MARK: - RefugesPointType+RefugesInfo

extension RefugePointType {
    var toRefugesInfoPointType: RefugesInfo.PointType? {
        switch self {
        case .crossingPoint: return .crossingPoint
        case .refuge: return .refuge
        case .summit: return .summit
        case .hut: return .hut
        case .bedAndBreakfast: return .bedAndBreakfast
        case .bivouac: return .bivouac
        case .water: return .water
        case .lake: return .lake
        }
    }
}
