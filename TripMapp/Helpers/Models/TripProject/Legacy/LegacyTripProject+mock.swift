//
//  TropProject+mock.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 15/05/2024.
//

import Foundation

extension LegacyTripProject {
    static var mock: LegacyTripProject {
        LegacyTripProject(name: "Project \(Int.random(in: 0 ... 100))")
    }
}
