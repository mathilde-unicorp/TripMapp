//
//  PersistenceController+setup.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 08/07/2024.
//

import Foundation

extension PersistenceController {
    func setupDefaultFavoriteTripPointTypes() {
        let tripPointTypes: [TripPointType] = [.summit, .foodstuffProvisions, .publicTransport, .refuge]

        for tripPointType in tripPointTypes {
            context.createTripPointTypeEntity(type: tripPointType)
        }
    }
}
