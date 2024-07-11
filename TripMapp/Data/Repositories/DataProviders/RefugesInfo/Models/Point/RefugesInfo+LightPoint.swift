//
//  RefugesInfo+LightPoint.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 24/08/2023.
//

import Foundation

extension RefugesInfo {

    /**
     A struct representing a point with an identifier and a name.

     - id: The identifier of the point.
     - name: The name of the point.
     */
    struct LightPoint: Codable {
        let id: RefugeId
        let name: String
        let type: RefugesInfo.PointType
        let coordinates: RefugesInfo.LightCoordinates
        let capacity: RefugesInfo.Capacity?

        enum CodingKeys: String, CodingKey {
            case id
            case name = "nom"
            case type
            case coordinates = "coord"
            case capacity = "places"
        }
    }

    /**
     A struct representing light coordinates properties from light refuges info points

     - altitude: known altitude of the point
     */
    struct LightCoordinates: Codable {
        let altitude: Int

        enum CodingKeys: String, CodingKey {
            case altitude = "alt"
        }
    }

}
