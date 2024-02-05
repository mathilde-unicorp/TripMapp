//
//  NetworkError.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 05/02/2024.
//

import Foundation

enum NetworkError: Error {
    case invalidURL(url: String)
    case invalidData
}
