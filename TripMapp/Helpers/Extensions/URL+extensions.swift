//
//  URL+extensions.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 05/05/2023.
//

import Foundation
import Unicorp_DataTypesLibrary

extension URL {
    static let cabaneClartan = URL(string: "https://www.refuges.info/point/3776/cabane-non-gardee/Lauziere-et-Grand-Arc/cabane-pastorale-de-Clartan/")!
    static let giteDeLaColleStMichel = URL(string: "https://www.refuges.info/point/1484/gite-d-etape/Gite-de-la-Colle-st-Michel/")!

    static let massifAlpes = URL(string: "https://www.refuges.info/nav/352/zone/Alpes/")!

    static let gr66Gpx = Bundle.main.url(forResource: "gr66", withExtension: "gpx")!
    static let gr70Gpx = Bundle.main.url(forResource: "gr70", withExtension: "gpx")!
}
