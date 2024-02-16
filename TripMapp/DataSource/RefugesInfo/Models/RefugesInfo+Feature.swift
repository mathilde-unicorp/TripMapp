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
    
    struct Feature<P: Codable, G: Codable>: Codable {
        let properties: P
        let geometry: G
    }

    struct NameValueField<T: Codable>: Codable {
        let name: String
        let value: T

        private enum CodingKeys: String, CodingKey {
            case name = "nom"
            case value = "valeur"
        }
    }
}
