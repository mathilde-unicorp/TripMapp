//
//  TripProjectEntity+Preview.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 16/07/2024.
//

import Foundation

extension TripProjectEntity {

    static var previewExample: TripProjectEntity = {
        let projectEntity = TripProjectEntity(context: .previewViewContext)
            .setup(name: "Project 1")

        let pointsEntities = [
            TripPointEntity(context: .previewViewContext)
                .setup(name: "Point1", type: .refuge)
                .setupLocation(coordinates: .cabaneClartan),
            TripPointEntity(context: .previewViewContext)
                .setup(name: "Point2", type: .foodstuffProvisions)
                .setupLocation(coordinates: .giteDeLaColleStMichel)
        ]

        pointsEntities.forEach { $0.addToProject(projectEntity) }

        return projectEntity
    }()
}
