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

    init(entity: TripProjectEntity) {
        self.name = entity.name ?? ""
        self.startDate = entity.startDate ?? .now
        self.endDate = entity.endDate ?? .now.adding(days: 7)
        self.notes = entity.notes ?? ""
    }
}
