//
//  TripProjectCreateViewModel.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 16/05/2024.
//

import Foundation

struct ImportedFile: Identifiable {
    let id = UUID()
    let url: URL
    let name: String
}
