//
//  RefugesInfo+Creator.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 24/08/2023.
//

import Foundation

extension RefugesInfo {

    struct Creator: Codable {
        let id: Int
        let name: String

        private enum CodingKeys: String, CodingKey {
            case id, name = "nom"
        }
    }
}
