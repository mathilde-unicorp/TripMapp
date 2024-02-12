//
//  RefugesInfo+Geometry.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 22/08/2023.
//

import Foundation
import MapKit

extension RefugesInfo {

    /**
     A struct representing a geometry object that conforms to the Codable protocol.

     - Parameters:
     - coordinates: An array of Double values representing the coordinates of the geometry.

     - Properties:
     - latitude: A computed property that returns the latitude value from the coordinates array.
     - longitude: A computed property that returns the longitude value from the coordinates array.
     - coordinated2D: A computed property that returns a CLLocationCoordinate2D object using the latitude and longitude values.
     */
    struct PointGeometry: Codable {
        let coordinates: [Double]

        // MARK: Computed properties

        var latitude: Double { return coordinates[1] }
        var longitude: Double { return coordinates[0] }

        var coordinate2D: CLLocationCoordinate2D {
            return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }
    }

    struct MultiPolygonGeometry: Codable {
        let coordinates: [[[[Double]]]]

        // MARK: Computed Properties

        var coordinates2D: [CLLocationCoordinate2D] {
            return coordinates[0][0].map {
                CLLocationCoordinate2D(latitude: $0[1], longitude: $0[0])
            }
        }
    }

}
