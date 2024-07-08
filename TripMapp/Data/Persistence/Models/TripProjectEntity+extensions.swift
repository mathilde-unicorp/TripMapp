//
//  TripProjectEntity+extensions.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 05/07/2024.
//

import CoreData

extension TripProjectEntity {

    // -------------------------------------------------------------------------
    // MARK: - Fetch Requests
    // -------------------------------------------------------------------------

    static var allProjectsRequest: NSFetchRequest<TripProjectEntity> {
        let request = TripProjectEntity.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \TripProjectEntity.startDate, ascending: false),
            NSSortDescriptor(keyPath: \TripProjectEntity.name, ascending: true)
        ]
        return request
    }
}
