//
//  RIResponse.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 04/05/2023.
//

import Foundation

extension RefugesInfo {

    typealias LightRefugePoint = RefugesInfo.Feature<RefugesInfo.LightPoint>
    typealias RefugePoint = RefugesInfo.Feature<RefugesInfo.Point>

    struct RefugeResponse<T: Codable>: Codable {
        let features: [RefugesInfo.Feature<T>]
    }

}
