//
//  TripLayer.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 15/05/2024.
//

import Foundation

struct TripLayer: Identifiable, Hashable {
    let id: UUID = UUID()

    var name: String
    var items: [UUID]
}
