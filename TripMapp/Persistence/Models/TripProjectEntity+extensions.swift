//
//  TripProjectEntity+extensions.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 24/05/2024.
//

import Foundation
import CoreData

extension TripProjectEntity {

    // -------------------------------------------------------------------------
    // MARK: - Initialization
    // -------------------------------------------------------------------------

    convenience init(
        context: NSManagedObjectContext,
        name: String,
        startDate: Date? = nil,
        endDate: Date? = nil
    ) {
        self.init(context: context)
        self.id = UUID()
        self.name = name
    }
}
