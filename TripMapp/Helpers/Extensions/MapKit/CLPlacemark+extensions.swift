//
//  MKMapitem+extensions.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 11/07/2024.
//

import Foundation
import MapKit

extension CLPlacemark {

    /// Get the same address, that could be provided by Google Places API
    /// https://developers.google.com/maps/documentation/javascript/examples/places-autocomplete
    var fullLocationAddress: String {
        let placemarkData: [String?] = [
            self.areasOfInterest?.first, // area
            self.thoroughfare, // street
            self.subThoroughfare, // building
            self.locality, // city
            self.subLocality, // sub city
            self.administrativeArea, // state
            self.subAdministrativeArea, // state area
            self.country
        ]

        return placemarkData
            .compactMap { $0.self }
            .removedDuplicates()
            .joined(separator: ", ")
    }

    /// Location adress with a minimum of informations to identify the places: street, city, country
    var shortLocationAddress: String {
        let placemarkData: [String?] = [
            self.thoroughfare, // street
            self.locality, // city
            self.country
        ]

        return placemarkData
            .compactMap { $0.self }
            .removedDuplicates()
            .joined(separator: ", ")
    }
}
