//
//  PersistenceRepository+setup.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 08/07/2024.
//

import Foundation

extension PersistenceRepository {

    /// Create default favorite trip point types to display on the map search bar
    func setupDefaultFavoriteTripPointTypes() {
        let tripPointTypes: [TripPointType] = [.summit, .foodstuffProvisions, .publicTransport, .refuge]

        for tripPointType in tripPointTypes {
            TripPointTypeEntity(context: context)
                .setup(type: tripPointType)
        }

        try? context.save()
    }
}
