//
//  TripProject.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 28/06/2024.
//

import Foundation

class TripProject: ObservableObject {
    @Published var name: String = ""

    @Published var startDate: Date
    @Published var endDate: Date

    @Published var notes: String = ""

    // -------------------------------------------------------------------------
    // MARK: - Initialization
    // -------------------------------------------------------------------------

    init(name: String, startDate: Date, endDate: Date, notes: String) {
        self.name = name
        self.startDate = startDate
        self.endDate = endDate
        self.notes = notes
    }
}

// =============================================================================
// MARK: - Build
// =============================================================================

extension TripProject {
    static func build(from entity: TripProjectEntity) -> TripProject {
        TripProject(
            name: entity.name ?? "",
            startDate: entity.startDate ?? .now,
            endDate: entity.endDate ?? .now.adding(days: 7),
            notes: entity.notes ?? ""
        )
    }
}
