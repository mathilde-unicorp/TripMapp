//
//  URL+extensions.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 05/05/2023.
//

import Foundation

extension URL {
    func getData() async throws -> Data {
        let (data, _) = try await URLSession.shared.data(from: self)
        return data
    }

    func get<T: Codable>(decoder: JSONDecoder = JSONDecoder()) async throws -> T {
        return try await self
            .getData()
            .decode(decoder: decoder)
    }
}
