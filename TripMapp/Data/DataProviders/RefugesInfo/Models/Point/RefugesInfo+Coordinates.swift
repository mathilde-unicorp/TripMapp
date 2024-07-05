//
//  RefugesInfo+Coordinates.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 24/08/2023.
//

import Foundation

extension RefugesInfo {

    struct Coordinates: Codable {
        let altitude: Int
        let longitude: String
        let latitude: String
        let precision: CoordinatesPrecision

        private enum CodingKeys: String, CodingKey {
            case altitude = "alt"
            case longitude = "long"
            case latitude = "lat"
            case precision
        }
    }

    struct CoordinatesPrecision: Codable {
        let name: String
        let type: Int

        private enum CodingKeys: String, CodingKey {
            case name = "nom"
            case type
        }
    }
}
