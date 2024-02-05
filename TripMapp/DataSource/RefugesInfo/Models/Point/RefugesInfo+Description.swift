//
//  RefugesInfo+OfficialWebsite.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 24/08/2023.
//

import Foundation

extension RefugesInfo {

    struct Description: Codable {
        let value: String

        private enum CodingKeys: String, CodingKey {
            case value = "valeur"
        }
    }

}
