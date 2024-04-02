//
//  RefugesInfoEndpoint.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 05/02/2024.
//

import Foundation
import Unicorp_APIBuilder

struct RefugesInfoEndpoint: APIEndpoint {
    var baseURL: String = "https://refuges.info"
    let defaultPath: String = "/api/"

    var contentType: ContentType = .json

    var headers: RefugesInfoHeader = [:]
    var body: [String: String]?

    var path: String
    var queryItems: [URLQueryItem]
}

typealias RefugesInfoHeader = [String: String]
