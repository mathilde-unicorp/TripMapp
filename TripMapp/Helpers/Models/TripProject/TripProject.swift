//
//  TripProject.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 15/04/2024.
//

import Foundation

struct TripProject: Identifiable, Hashable {
    let id: UUID = UUID()
    let name: String

    var markers: [TripMarker] = []
    var traces: [TripTrace] = []

    var layers: [TripLayer] = []
}
