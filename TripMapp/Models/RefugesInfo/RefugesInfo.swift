//
//  RefugesInfo.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 22/08/2023.
//

import Foundation

/// Base Structure containing all RefugesInfo Structures required to process network request
struct RefugesInfo {

    // MARK: - Basic Components of requests
    
    struct Feature<T: Codable>: Codable {
        let properties: T
        let geometry: RefugesInfo.Geometry
    }
}
