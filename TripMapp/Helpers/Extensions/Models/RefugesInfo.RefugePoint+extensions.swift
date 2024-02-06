//
//  RefugesInfo.RefugePoint.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 24/08/2023.
//

import Foundation

extension RefugesInfo.RefugePoint {
    var toLightPoint: RefugesInfo.LightRefugePoint {
        RefugesInfo.LightRefugePoint(
            properties: self.properties.toLightPoint,
            geometry: self.geometry
        )
    }
}
