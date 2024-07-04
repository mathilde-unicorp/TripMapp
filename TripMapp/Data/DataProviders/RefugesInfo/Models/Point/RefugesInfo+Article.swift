//
//  RefugesInfo+Article.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 24/08/2023.
//

import Foundation

extension RefugesInfo {

    struct Article: Codable {
        let demonstrative: String
        let definite: String
        let partitive: String

        private enum CodingKeys: String, CodingKey {
            case demonstrative = "demonstratif"
            case definite = "defini"
            case partitive = "partitif"
        }
    }
}
