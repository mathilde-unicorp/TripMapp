//
//  MapContentModel.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 19/02/2024.
//

import Foundation

struct MapContentModel {
    var annotations: Set<MapAnnotationModel>
    var polygons: Set<MapPolygonModel>

    mutating func insert(annotations: [MapAnnotationModel]) {
        annotations.forEach { annotation in
            self.annotations.insert(annotation)
        }
    }

    mutating func insert(polygons: [MapPolygonModel]) {
        polygons.forEach { polygon in
            self.polygons.insert(polygon)
        }
    }
}
