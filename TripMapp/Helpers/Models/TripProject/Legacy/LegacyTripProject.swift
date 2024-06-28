//
//  LegacyTripProject.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 15/04/2024.
//

import Foundation

struct LegacyTripProject: Identifiable, Hashable {
    let id: UUID = UUID()
    var name: String

    var startDate: Date?
    var endDate: Date?

    var notes: String = ""

    var markers: [TripMarker] = []
    var traces: [TripTrace] = []

    var layers: [TripLayer] = []
}
