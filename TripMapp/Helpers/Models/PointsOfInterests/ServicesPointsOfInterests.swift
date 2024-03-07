//
//  ServicesPointsOfInterests.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 05/03/2024.
//

import Foundation
import SwiftUI
import MapKit

enum ServicesPointsOfInterests: String, CaseIterable {
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
}

// -------------------------------------------------------------------------
// MARK: - Map Search
// -------------------------------------------------------------------------

extension ServicesPointsOfInterests: PointsOfInterestsCategory {
    var mkPointOfInterestFilter: MKPointOfInterestFilter {
        return .init(including: mkPointsOfInterestCategories)
    }

    var mkPointsOfInterestCategories: [MKPointOfInterestCategory] {
        switch self {
        case .foodstuffProvisions:
            return [.foodMarket]
        case .sportsProvisions:
            return [.store]
        case .laundryRoom:
            return [.laundry]
        case .restaurant:
            return [.bakery, .restaurant]
        case .pharmacy:
            return [.hospital, .pharmacy]
        case .postOffice:
            return [.postOffice]
        case .bank:
            return [.atm, .bank]
        case .publicTransport:
            return [.publicTransport]
        case .breakSpot:
            return [.cafe, .brewery, .movieTheater]
        case .restroom:
            return [.restroom]
        }
    }

    var defaultQuery: String {
        switch self {
        case .sportsProvisions:
            return "sport"
        case .bank:
            return "banque"
        case .breakSpot:
            return ""
        case .foodstuffProvisions:
            return "épicerie"
        case .laundryRoom:
            return "laverie"
        case .pharmacy:
            return "pharmacie"
        case .postOffice:
            return "poste"
        case .publicTransport:
            return "gare"
        case .restaurant:
            return "restaurant"
        case .restroom:
            return "toilettes"
        }
    }
}

// -------------------------------------------------------------------------
// MARK: - Label
// -------------------------------------------------------------------------

extension ServicesPointsOfInterests {
    var name: String {
        return self.rawValue.fromCamelCaseToNaturalWord.capitalized
    }

    var image: Image {
        switch self {
        case .foodstuffProvisions:
            return Image(systemName: "cart.fill")
        case .sportsProvisions:
            return Image(systemName: "tshirt.fill")
        case .laundryRoom:
            return Image(systemName: "washer.fill")
        case .restaurant:
            return Image(systemName: "fork.knife")
        case .pharmacy:
            return Image(systemName: "cross.case.fill")
        case .postOffice:
            return Image(systemName: "envelope.fill")
        case .bank:
            return Image(systemName: "banknote.fill")
        case .publicTransport:
            return Image(systemName: "tram.fill")
        case .restroom:
            return Image(systemName: "figure.dress.line.vertical.figure")
        case .breakSpot:
            return Image(systemName: "cup.and.saucer.fill")
        }
    }
}

#Preview {
    List(ServicesPointsOfInterests.allCases, id: \.self) { service in
        Label(
            title: { Text(service.name) },
            icon: { service.image }
        )
    }
}
