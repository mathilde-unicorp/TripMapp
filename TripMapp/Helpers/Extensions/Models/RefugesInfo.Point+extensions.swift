//
//  RefugesInfo.Point+extensions.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 24/08/2023.
//

import Foundation

extension RefugesInfo.Point {

    /**
     Creates a `LightPoint` object based on the current instance of `RefugesInfo.Point`.

     - Returns: A `LightPoint` object with the same `id`, `name`, and `type` as the current instance of `RefugesInfo`.
     */
    var toLightPoint: RefugesInfo.LightPoint {
        RefugesInfo.LightPoint(
            id: self.id,
            name: self.name,
            type: self.type
        )
    }
}
