//
//  Endpoint.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 26/01/2024.
//

import Foundation

struct Endpoint {
    var path: String
    var queryItems = [URLQueryItem]()
}

extension Endpoint {

    // MARK: Configuration

    static let baseURL = "refuges.info"

    func buildURL() -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "refuges.info"
        components.path = "/api/" + path
        components.queryItems = queryItems.isEmpty ? nil : queryItems

        // If either the path or the query items passed contained
        // invalid characters, we'll get a nil URL back
        return components.url
    }
}
