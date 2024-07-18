//
//  TripProjectEntity+Preview.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 16/07/2024.
//

import Foundation

extension TripProjectEntity {

    static var previewExample: TripProjectEntity = {
        TripProjectEntity(context: .previewViewContext)
            .setup(name: "Project 1")
    }()
}
