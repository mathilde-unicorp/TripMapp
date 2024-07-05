//
//  PointsOfInterestsCategory.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 05/03/2024.
//

import Foundation
import MapKit
import SwiftUI

typealias POIType = PointsOfInterestType

/// All type of PointsOfInterest that can be search through the app
enum PointsOfInterestType: Int, CaseIterable {
    case summit = 0
    case waypoint
    case water
    case lake

    case foodstuffProvisions
    case sportsProvisions
    case laundryRoom
    case restaurant
    case pharmacy
    case postOffice
    case bank
    case publicTransport
    case restroom
    case breakSpot

    case refuge
    case cottage
    case campground
    case hotel
    case bivouac
}

extension PointsOfInterestType: Identifiable {
    var id: Int { return rawValue }
}

// -------------------------------------------------------------------------
// MARK: - PointsOfInterestType + RefugesInfo
// -------------------------------------------------------------------------
extension PointsOfInterestType {
    var toRefugesInfoPointType: RefugesInfo.PointType? {
        switch self {
        case .summit: return .summit
        case .waypoint: return .crossingPoint
        case .water: return .water
        case .lake: return .lake
        case .refuge: return .refuge
        case .cottage: return .bedAndBreakfast
        case .bivouac: return .bivouac
        default: return nil
        }
    }
}

// =============================================================================
// MARK: - Computed Properties
// =============================================================================

extension PointsOfInterestType {

    var title: LocalizedStringKey {
        switch self {
        case .summit: return "points_of_interest.summit"
        case .waypoint: return "points_of_interest.waypoint"
        case .water: return "points_of_interest.water"
        case .lake: return "points_of_interest.lake"

        case .foodstuffProvisions: return "points_of_interest.foodstuff_provisions"
        case .sportsProvisions: return "points_of_interest.sports_provisions"
        case .laundryRoom: return "points_of_interest.laundry_room"
        case .restaurant: return "points_of_interest.restaurant"
        case .pharmacy: return "points_of_interest.pharmacy"
        case .postOffice: return "points_of_interest.post_office"
        case .bank: return "points_of_interest.bank"
        case .publicTransport: return "points_of_interest.public_transport"
        case .restroom: return "points_of_interest.restroom"
        case .breakSpot: return "points_of_interest.break_spot"

        case .refuge: return "points_of_interest.refuge"
        case .cottage: return "points_of_interest.cottage"
        case .campground: return "points_of_interest.campground"
        case .hotel: return "points_of_interest.hotel"
        case .bivouac: return "points_of_interest.bivouac"
        }
    }

    var systemImage: String {
        switch self {
        case .summit: return "mountain.2.fill"
        case .waypoint: return "mappin"
        case .water: return "drop.fill"
        case .lake: return "figure.open.water.swim"

        case .foodstuffProvisions: return "cart.fill"
        case .sportsProvisions: return "tshirt.fill"
        case .laundryRoom: return "washer.fill"
        case .restaurant: return "fork.knife"
        case .pharmacy: return "cross.case.fill"
        case .postOffice: return "envelope.fill"
        case .bank: return "banknote.fill"
        case .publicTransport: return "tram.fill"
        case .restroom: return "figure.dress.line.vertical.figure"
        case .breakSpot: return "cup.and.saucer.fill"

        case .refuge: return "house.fill"
        case .cottage: return "bed.double.fill"
        case .campground: return "tent.2.fill"
        case .hotel: return "building.fill"
        case .bivouac: return "tent.fill"
        }
    }

    var category: PointsOfInterestType.Category {
        switch self {
        case .summit, .waypoint, .water, .lake:
            return .hiking
        case .foodstuffProvisions,
                .sportsProvisions,
                .laundryRoom,
                .restaurant,
                .pharmacy,
                .postOffice,
                .bank,
                .publicTransport,
                .restroom,
                .breakSpot:
            return .service
        case .refuge,
                .cottage,
                .campground,
                .hotel,
                .bivouac:
            return .accommodation
        }
    }

    var color: Color {
        return category.color
    }
}
