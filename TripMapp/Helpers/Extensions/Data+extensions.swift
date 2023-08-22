//
//  Data+extensions.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 05/05/2023.
//

import Foundation

extension Data {
    func decode<T: Codable>(decoder: JSONDecoder = JSONDecoder()) async throws -> T {
        return try decoder.decode(T.self, from: self)
    }
}
