//
//  RefugesInfo+Maintenance.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 24/08/2023.
//

import Foundation

extension RefugesInfo {

    struct Maintenance: Codable {
        let valeur: String
        let id: String

        private enum CodingKeys: String, CodingKey {
            case valeur, id
        }
    }

}
