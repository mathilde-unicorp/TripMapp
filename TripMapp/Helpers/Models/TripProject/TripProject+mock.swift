//
//  TropProject+mock.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 15/05/2024.
//

import Foundation

extension TripProject {
    static var mock: TripProject {
        TripProject(name: "Project \(Int.random(in: 0 ... 100))")
    }
}
