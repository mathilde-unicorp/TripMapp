//
//  RefugesInfo+Massif.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 25/08/2023.
//

import Foundation

extension RefugesInfo {
    /// Id representing a type of massif in RefugesInfo database
    enum MassifType: String {
        /// Local Massifs
        case massif = "1"
        /// Bigger massifs
        case zone = "11"
    }

    typealias MassifId = String

    /// Id representing a specific massif in RefugesInfo database
    enum DefaultMassifId: MassifId {
        case pyrenees = "351"
        case alpes = "352"
        case corse = "748"
        case jura = "3307"
        case massifCentral = "50"
        case massifsMeridionnaux = "5053"
        case vosges = "747"
    }
}
