//
//  RefugesInfoEndpoint.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 05/02/2024.
//

import Foundation

struct RefugesInfoEndpoint: Endpoint {
    let scheme: String = "https"
    let host: String = "refuges.info"
    let defaultPath: String = "/api/"

    var path: String
    var queryItems: [URLQueryItem]
}
