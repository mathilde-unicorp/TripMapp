//
//  RefugesInfo+Description.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 24/08/2023.
//

import Foundation

extension RefugesInfo {

    struct AdditionalInfo: Codable {
        let officialSite: OfficialSite
        let missingWall: NameValueField<String?>
        let fireplace: NameValueField<String?>
        let stove: NameValueField<String?>
        let blankets: NameValueField<String?>
        let mattressPlaces: MattressPlaces
        let toilets: NameValueField<String?>
        let wood: NameValueField<String?>
        let water: NameValueField<String?>

        private enum CodingKeys: String, CodingKey {
            case officialSite = "site_officiel"
            case missingWall = "manque_un_mur"
            case fireplace = "cheminee"
            case stove = "poele"
            case blankets = "couvertures"
            case mattressPlaces = "places_matelas"
            case toilets = "latrines"
            case wood = "bois"
            case water = "eau"
        }
    }

    struct OfficialSite: Codable {
        let name: String
        let url: String
        let value: String

        private enum CodingKeys: String, CodingKey {
            case name = "nom"
            case url
            case value = "valeur"
        }
    }
    
    struct MattressPlaces: Codable {
        let name: String
        let count: String?
        let value: String

        private enum CodingKeys: String, CodingKey {
            case name = "nom"
            case count = "nb"
            case value = "valeur"
        }
    }
}
