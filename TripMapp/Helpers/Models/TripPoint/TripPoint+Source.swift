//
//  TripPoint+Source.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 18/07/2024.
//

import Foundation
import MapKit

extension TripPoint {
    enum Source {
        case refugesInfo(refugeId: RefugeId)
        case mkMap(item: MKMapItem)
        case custom

        var name: String {
            switch self {
            case .refugesInfo: "refugesInfo"
            case .mkMap: "mkMapItem"
            case .custom: "custom"
            }
        }

        var sourceId: String? {
            switch self {
            case .refugesInfo(let refugeId): refugeId.toString
            default: nil
            }
        }
    }
}
