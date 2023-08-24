//
//  RefugesInfoPoint.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 04/05/2023.
//

import Foundation

extension RefugesInfo {

    struct Point: Codable {
        let id: Int
        let link: URL
        let name: String
        let symbol: String
        let coordinates: Coordinates
        let type: RefugesInfo.PointType
        let capacity: Capacity
        let maintenance: Maintenance
        let date: DateInfo
        let note: Note
        let access: Access
        let owner: Owner
        let creator: Creator
        let article: Article
        let additionnalInfo: AdditionalInfo
        let description: Description

        private enum CodingKeys: String, CodingKey {
            case id
            case link = "lien"
            case name = "nom"
            case symbol = "sym"
            case coordinates = "coord"
            case type
            case capacity = "places"
            case maintenance = "etat"
            case date
            case note = "remarque"
            case access = "acces"
            case owner = "proprio"
            case creator = "createur"
            case article
            case additionnalInfo = "info_comp"
            case description
        }
    }

    typealias Capacity = NameValueField<Int>

    typealias Note = NameValueField<String>

    typealias Access = NameValueField<String>

    typealias Owner = NameValueField<String>
}
