//
//  RefugesInfoPoint.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 04/05/2023.
//

import Foundation

extension RefugesInfo {

    /**
     A struct representing a point with an identifier and a name.

     - id: The identifier of the point.
     - name: The name of the point.
     */
    struct Point: Codable {
        let id: Int
        let name: String
        let type: RefugesInfo.PointType

        enum CodingKeys: String, CodingKey {
            case id
            case name = "nom"
            case type
        }
    }

}
