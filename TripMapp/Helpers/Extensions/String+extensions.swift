//
//  String+extensions.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 05/03/2024.
//

import Foundation

extension String {
    /// Convert a string in camel case to a natural word
    var fromCamelCaseToNaturalWord: String {
        return self
            .replacingOccurrences(of: "([a-z])([A-Z])", with: "$1 $2", options: .regularExpression)
    }
}
