//
//  Array+CLLocationCoordinate2D.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 25/08/2023.
//

import Foundation
import CoreLocation

extension Array where Element == CLLocationCoordinate2D {

    /**
     Calculates the central point of an array of coordinates.

     - Returns: The central point as a `CLLocationCoordinate2D` object, or `nil` if the array is empty.
     */
    func calculateCentralPoint() -> CLLocationCoordinate2D? {
        guard !self.isEmpty else {
            return nil
        }

        var minLatitude = self[0].latitude
        var maxLatitude = self[0].latitude
        var minLongitude = self[0].longitude
        var maxLongitude = self[0].longitude

        for coordinate in self {
            minLatitude = Swift.min(minLatitude, coordinate.latitude)
            maxLatitude = Swift.max(maxLatitude, coordinate.latitude)
            minLongitude = Swift.min(minLongitude, coordinate.longitude)
            maxLongitude = Swift.max(maxLongitude, coordinate.longitude)
        }

        let centralLatitude = (minLatitude + maxLatitude) / 2
        let centralLongitude = (minLongitude + maxLongitude) / 2

        return CLLocationCoordinate2D(latitude: centralLatitude, longitude: centralLongitude)
    }

    /**
     Calculates the maximum latitude delta for a given array of coordinates.

     - Parameters:
     - coordinates: An array of CLLocationCoordinate2D objects representing the coordinates.

     - Returns: The maximum latitude delta as a CLLocationDegrees value. Returns nil if the array is empty.

     - Note: The maximum latitude delta is calculated by finding the minimum and maximum latitude values from the given coordinates array and subtracting them.

     - Complexity: O(n), where n is the number of coordinates in the array.
     */
    func calculateMaximumLatitudeDelta(for coordinates: [CLLocationCoordinate2D]) -> CLLocationDegrees? {
        guard !self.isEmpty else {
            return nil
        }

        var minLatitude = self[0].latitude
        var maxLatitude = self[0].latitude

        for coordinate in self {
            minLatitude = Swift.min(minLatitude, coordinate.latitude)
            maxLatitude = Swift.max(maxLatitude, coordinate.latitude)
        }

        return maxLatitude - minLatitude
    }

    func calculateMaximumLongitudeDelta(for coordinates: [CLLocationCoordinate2D]) -> CLLocationDegrees? {
        guard !self.isEmpty else {
            return nil
        }

        var minLongitude = self[0].longitude
        var maxLongitude = self[0].longitude

        for coordinate in self {
            minLongitude = Swift.min(minLongitude, coordinate.longitude)
            maxLongitude = Swift.max(maxLongitude, coordinate.longitude)
        }

        return maxLongitude - minLongitude
    }
}
