//
//  MapLayer.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 07/04/2024.
//

import Foundation
import MapKit

struct MapLayerModel<
    Marker: MapMarkerModel,
    Polyline: MapPolylineModel,
    Polygon: MapPolygonModel
> {
    let id: UUID = UUID()
    let name: String

    let markers: [Marker]
    let polylines: [Polyline]
    let polygons: [Polygon]
}
