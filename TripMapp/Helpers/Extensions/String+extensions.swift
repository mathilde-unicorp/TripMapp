//
//  String+extensions.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 05/05/2023.
//

import Foundation

extension String {
    var toURL: URL? {
        return URL(string: self)
    }
}
