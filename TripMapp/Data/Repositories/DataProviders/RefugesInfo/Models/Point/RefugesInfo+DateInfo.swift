//
//  RefugesInfo+DateInfo.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 24/08/2023.
//

import Foundation

extension RefugesInfo {

    struct DateInfo: Codable {
        let lastModified: String
        let creation: String

        init(lastModified: String, creation: String) {
            self.lastModified = lastModified
            self.creation = creation
        }

        init(lastModified: Date, creation: Date) { // TEMP init until convert String to Date with a date decoder.
            self.lastModified = lastModified.description
            self.creation = creation.description
        }

        private enum CodingKeys: String, CodingKey {
            case lastModified = "derniere_modif"
            case creation
        }
    }
}
