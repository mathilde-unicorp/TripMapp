//
//  RefugesInfo+Polygon.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 09/02/2024.
//

import Foundation

extension RefugesInfo {

    struct Polygon: Codable {
        let id: Int
        let name: String
        let type: PolygonType
        let link: URL
        let colorHexa: String

        enum CodingKeys: String, CodingKey {
            case id
            case name = "nom"
            case type
            case link = "lien"
            case colorHexa = "couleur"
        }
    }

    struct PolygonType: Codable {
        let id: Int
        let category: String
        let type: String

        enum CodingKeys: String, CodingKey {
            case id
            case category = "categorie"
            case type
        }
    }
}
