//
//  Endpoint.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 26/01/2024.
//

import Foundation

protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var defaultPath: String { get }

    var path: String { get set }
    var queryItems: [URLQueryItem] { get set }
}

extension Endpoint {

    // MARK: Configuration

    private func buildURL() -> URL? {
        var components = URLComponents()
        components.scheme = self.scheme
        components.host = self.host
        components.path = self.defaultPath + path
        components.queryItems = self.queryItems.isEmpty ? nil : self.queryItems

        // If either the path or the query items passed contained
        // invalid characters, we'll get a nil URL back
        return components.url
    }

    func get<T: Codable>(session: URLSession = .shared) async throws -> T {
        guard let url = self.buildURL() else {
            throw NetworkError.invalidURL(url: self.path)
        }

        do {
            return try await url.get(session: session)
        } catch {
            print("Invalid data: \(error)")
            throw error
        }
    }
}
